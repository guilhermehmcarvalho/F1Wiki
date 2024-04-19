//
//  DriverStandingsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import Foundation
import Combine

class DriverStandingsViewModel: ObservableObject {

  let apiSeasons: APISeasonsProtocol

  @Published var fetchStatus: FetchStatus = .ready
  @Published var driverStandings: [DriverStanding]?
  @Published var selectedTab: Int = 0
  @Published var errorToast: Toast?

  private var cancellable: AnyCancellable?
  private var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private var toastSubject = PassthroughSubject<Toast?, Never>()

  init(apiSeasons: APISeasonsProtocol) {
    self.apiSeasons = apiSeasons
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
     toastSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorToast)
  }

  func fetchDriverStandings() {
    guard driverStandings == nil else { return }
    cancellable = apiSeasons.currentSeasonDriverStandings()
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in }  receiveValue: { [weak self] response in
        self?.driverStandings = response.table.standingsLists.first?.driverStandings
      }
  }
}
