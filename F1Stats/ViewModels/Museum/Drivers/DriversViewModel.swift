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
  private let wikipediaAPI: WikipediaAPIProtocol

  private var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private var toastSubject = PassthroughSubject<Toast?, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var driverList: [Driver] = []
  @Published var errorToast: Toast?

  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
//  private var totalDrivers = 0;
  private var paginationThresholdId: String?

  init(driverApi: APIDriversProtocol, wikipediaAPI: WikipediaAPIProtocol) {
    self.driverApi = driverApi
    self.wikipediaAPI = wikipediaAPI
  }
  
  func fetchDrivers() {
    cancellable = driverApi.listOfAllDrivers(limit: itemsPerPage, offset: offset)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .assignToastForError(with: toastSubject)
      .sink { _ in } receiveValue: { [weak self] response in
        self?.driverList.append(contentsOf: response)
        self?.offset += response.count
//        self?.totalDrivers = response.total
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
//  func onItemDisplayed(currentItem item: Driver){
//    if item.driverId == paginationThresholdId, driverList.count < totalDrivers {
//      fetchDrivers()
//    }
//  }
}
