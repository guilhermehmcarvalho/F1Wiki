//
//  ScheduleViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//


import Foundation
import Combine
import UIKit

class RacesViewModel: ObservableObject {

  private var apiSchedule: APIScheduleProtocol
  private let wikipediaAPI: WikipediaAPIProtocol

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var raceList: [RaceModel] = []

  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
  private var total = 0;
  private var paginationThresholdId: String?

  init(apiSchedule: APIScheduleProtocol, wikipediaAPI: WikipediaAPIProtocol) {
    self.apiSchedule = apiSchedule
    self.wikipediaAPI = wikipediaAPI
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  func fetchCurrentSchedule() {
    cancellable = apiSchedule.currentSeasonSchedule(limit: itemsPerPage, offset: offset)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.raceList.append(contentsOf: response.table.races)
        self?.offset += response.table.races.count
        self?.total = response.total
        if let self = self {
          var thresholdIndex = self.raceList.index(self.raceList.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = raceList[thresholdIndex].id
        }
      }
  }

//  internal func driverRoleViewModel(for driver: DriverModel) -> DriverRowViewModel {
//    DriverRowViewModel(driver: driver, wikipediaApi:
//                        wikipediaAPI, driverApi: driverApi)
//  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: DriverModel){
    if item.id == paginationThresholdId, raceList.count < total {
      fetchCurrentSchedule()
    }
  }
}
