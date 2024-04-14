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

  private var cancellable: AnyCancellable?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  init(apiSeasons: APISeasonsProtocol) {
    self.apiSeasons = apiSeasons
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  func fetchDriverStandings() {
    cancellable = apiSeasons.currentSeasonDriverStandings()
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      }  receiveValue: { [weak self] response in
        self?.driverStandings = response.table.standingsLists.first?.driverStandings
      }
  }

}
