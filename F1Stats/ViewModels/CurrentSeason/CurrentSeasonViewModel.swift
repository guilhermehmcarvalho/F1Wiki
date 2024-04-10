//
//  ScheduleViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//


import Foundation
import Combine
import UIKit

class CurrentSeasonViewModel: ObservableObject {

  private var apiSeasons: APISeasonsProtocol
  private let wikipediaAPI: WikipediaAPIProtocol

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var raceViewModels: [RaceViewModel] = []
  var selectedIndex = 0;

  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
  private var total = 0;
  private var paginationThresholdId: String?

  init(apiSeasons: APISeasonsProtocol, wikipediaAPI: WikipediaAPIProtocol) {
    self.apiSeasons = apiSeasons
    self.wikipediaAPI = wikipediaAPI
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  func fetchCurrentSchedule() {
    cancellable = apiSeasons.currentSeasonSchedule(limit: itemsPerPage, offset: offset)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        let raceVMs = response.table.races.map { race in
          RaceViewModel(raceModel: race)
        }
        self?.raceViewModels.append(contentsOf: raceVMs)
        self?.offset += response.table.races.count
        self?.total = response.total
        if let self = self {
          var thresholdIndex = self.raceViewModels.index(self.raceViewModels.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = raceViewModels[thresholdIndex].id
        }
      }
  }

  internal func changedTabIndex(oldValue: Int, newValue: Int) {
    raceViewModels[oldValue].animate(false)
    raceViewModels[newValue].animate(true)
  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: DriverModel){
    if item.id == paginationThresholdId, raceViewModels.count < total {
      fetchCurrentSchedule()
    }
  }
}
