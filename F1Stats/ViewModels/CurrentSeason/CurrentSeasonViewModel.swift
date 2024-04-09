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
  @Published var selectedRace: RaceModel?
  @Published var hasNextRace: Bool = false
  @Published var hasPreviousRace: Bool = false
  @Published var raceList: [RaceModel] = []
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
        self?.raceList.append(contentsOf: response.table.races)
        self?.offset += response.table.races.count
        self?.total = response.total
        self?.selectRace()
        if let self = self {
          var thresholdIndex = self.raceList.index(self.raceList.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = raceList[thresholdIndex].id
        }
      }
  }

  private func selectRace() {
    selectedRace = self.raceList[self.selectedIndex]
    hasNextRace = selectedIndex + 1 < raceList.count
    hasPreviousRace = selectedIndex > 0
  }

  internal func selectNextRace() {
    if selectedIndex + 1 < raceList.count {
      selectedIndex += 1
    }
    selectRace()
  }

  internal func selectPreviousRace() {
    if selectedIndex - 1 >= 0 {
      selectedIndex -= 1
    }
    selectRace()
  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: DriverModel){
    if item.id == paginationThresholdId, raceList.count < total {
      fetchCurrentSchedule()
    }
  }
}
