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
  let apiDriver: APIDriversProtocol
  let wikipediaAPI: WikipediaAPIProtocol

  @Published var fetchStatus: FetchStatus = .ready
  @Published var driverStandings: [DriverStanding]?
  @Published var selectedTab: Int = 0
  @Published var presentingDriverCard: Bool = false
  @Published var driverCardViewModel: DriverCardViewModel?

  private var cancellable: AnyCancellable?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  init(apiSeasons: APISeasonsProtocol,
       apiDriver: APIDriversProtocol,
       wikipediaAPI: WikipediaAPIProtocol) {
    self.apiSeasons = apiSeasons
    self.apiDriver = apiDriver
    self.wikipediaAPI = wikipediaAPI
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

  func didTapRow(_ standing: DriverStanding) {
    driverCardViewModel = DriverCardViewModel(driver: standing.driver,
                                              wikipediaApi: wikipediaAPI,
                                              driverApi: apiDriver)
    presentingDriverCard = true
  }

  func dismissedCardView() {
    driverCardViewModel = nil
    presentingDriverCard = false
  }

}
