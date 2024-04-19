//
//  ScheduleViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//


import Foundation
import Combine
import SwiftUI

class CurrentSeasonViewModel: ObservableObject {

  private var apiSeasons: APISeasonsProtocol

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private var toastSubject = PassthroughSubject<Toast?, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var raceViewModels: [RaceViewModel] = []
  @Published var selectedIndex: Int = 0
  @Published var errorToast: Toast?

  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
  private var total = 0;
  private var paginationThresholdId: String?

  init(apiSeasons: APISeasonsProtocol) {
    self.apiSeasons = apiSeasons

    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)

     toastSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorToast)
  }

  func fetchCurrentSchedule() {
    cancellable = apiSeasons.currentSeasonSchedule(limit: itemsPerPage, offset: offset)
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] response in

        self?.offset += response.table.races.count
        self?.total = response.total
        if let self = self {
          let raceVMs: [RaceViewModel] = response.table.races.map { raceModel in
            RaceViewModel(raceModel: raceModel, apiSeasons: self.apiSeasons)
          }
          self.raceViewModels.append(contentsOf: raceVMs)

          var thresholdIndex = self.raceViewModels.index(self.raceViewModels.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = raceViewModels[thresholdIndex].id
          selectClosestGrandPrix()
          raceViewModels[selectedIndex].animate(true, delay: 0.1)
        }
      }
  }

  // If an event starts in a day or less, selects it
  // ..if not, we select the last finished event
  func selectClosestGrandPrix() {
    for i in 0..<raceViewModels.count {
      if raceViewModels[i].raceModel.startsInADay() {
        selectedIndex = i
        return
      } else if raceViewModels[i].raceModel.isFinished() {
        selectedIndex = i
      }
    }
  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: RaceViewModel){
    item.animate(true)
    if item.id == paginationThresholdId, raceViewModels.count < total {
      fetchCurrentSchedule()
    }
  }
}

extension RaceModel {
  func startsInADay() -> Bool {
    return self.startsInADay || 
    qualifying?.startsInADay ?? false ||
    sprint?.startsInADay ?? false ||
    firstPractice?.startsInADay ?? false ||
    secondPractice?.startsInADay ?? false ||
    thirdPractice?.startsInADay ?? false
  }
}

extension EventProtocol {
  var timeToNow: TimeInterval? {
    return timeAsDate()?.distance(to: Date.now)
  }

  var startsInADay: Bool {
    if let timeToNow = timeToNow {
      let hours = timeToNow/3600
      if hours > 0 && hours < 24 || hours < 0 && hours > -24 {
        return true
      }
    }

    return false
  }
}
