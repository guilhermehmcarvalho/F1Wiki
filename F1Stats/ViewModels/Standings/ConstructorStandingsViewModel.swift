//
//  ConstructorStandingsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import Foundation
import Combine

class ConstructorStandingsViewModel: ObservableObject {
  let apiSeasons: APISeasonsProtocol

  @Published var fetchStatus: FetchStatus = .ready
  @Published var constructorStandings: [ConstructorStanding]?
  @Published var selectedTab: Int = 0

  private var cancellable: AnyCancellable?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  init(apiSeasons: APISeasonsProtocol) {
    self.apiSeasons = apiSeasons
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  func fetchConstructorStandings() {
    cancellable = apiSeasons.currentSeasonConstructorStandings()
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      }
    receiveValue: { [weak self] response in
      self?.constructorStandings = response.table.standingsLists.first?.constructorStanding
    }
  }

}
