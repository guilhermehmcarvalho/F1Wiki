//
//  SeasonConstructorStandingsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import Foundation
import Combine

class SeasonConstructorStandingsViewModel: ObservableObject {

  private var apiSeasons: APISeasonsProtocol
  private let seasonId: String
  @Published var standingLists: [StandingsList]?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  @Published var fetchStatus: FetchStatus = .ready

  private var cancellable: AnyCancellable?

  init(seasonId: String, apiSeasons: APISeasonsProtocol) {
    self.seasonId = seasonId
    self.apiSeasons = apiSeasons
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  func onTap(isExpanded: Bool) {
    if isExpanded, standingLists == nil {
      fetchStandings()
    }
  }

  internal func fetchStandings() {
    cancellable = apiSeasons.constructorStandingsForSeason(season: seasonId)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { error in
        print(error)
      } receiveValue: { [weak self] response in
        self?.standingLists = response.table.standingsLists
      }
  }
}
