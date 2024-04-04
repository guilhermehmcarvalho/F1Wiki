//
//  ContentViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine
import UIKit

class DriversViewModel: ObservableObject {
  
  private var driverApi: APIDriversProtocol
  internal let wikipediaAPI: WikipediaAPIProtocol

  @Published var fetchStatus: FetchStatus = .ready
  @Published var driverList: [DriverModel] = []
  
  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
  private var totalDrivers = 0;
  private var paginationThresholdId: String?

  init(driverApi: APIDriversProtocol, wikipediaAPI: WikipediaAPIProtocol) {
    self.driverApi = driverApi
    self.wikipediaAPI = wikipediaAPI
  }
  
  func fetchDrivers() {
    cancellable = driverApi.listOfAllDrivers(limit: itemsPerPage, offset: offset)
      .handleEvents(receiveSubscription: { [weak self] _ in
        DispatchQueue.main.async {
          self?.fetchStatus = .ongoing
        }
      }, receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          DispatchQueue.main.async {
            self?.fetchStatus = .finished
          }
        case .failure:
          DispatchQueue.main.async {
            self?.fetchStatus = .ready
          }
        }
      }, receiveCancel: { [weak self] in
        DispatchQueue.main.async {
          self?.fetchStatus = .ready
        }
      })
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.driverList.append(contentsOf: response.table.drivers)
        self?.offset += response.table.drivers.count
        self?.totalDrivers = response.total
        if let self = self {
          var thresholdIndex = self.driverList.index(self.driverList.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = driverList[thresholdIndex].driverId
        }
      }
  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: DriverModel){
    if item.driverId == paginationThresholdId, driverList.count < totalDrivers {
      fetchDrivers()
    }
  }

  func updateFetchStatus() {

  }
}
