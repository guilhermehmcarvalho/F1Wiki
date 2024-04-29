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
  @Published var fetchStatus: FetchStatus = .ready
  @Published var errorToast: Toast?

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private var toastSubject = PassthroughSubject<Toast?, Never>()
  private var cancellable: AnyCancellable?

  init(seasonId: String, apiSeasons: APISeasonsProtocol) {
    self.seasonId = seasonId
    self.apiSeasons = apiSeasons

    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)

    toastSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorToast)
  }

  func onTap(isExpanded: Bool) {
    if isExpanded, standingLists == nil {
      fetchStandings()
    }
  }

  internal func fetchStandings() {
    cancellable = apiSeasons.constructorStandingsForSeason(season: seasonId)
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in }  receiveValue: { [weak self] response in
        self?.standingLists = response.table.standingsLists
      }
  }
}
