//
//  RaceResultsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 10/04/2024.
//

import Foundation
import Combine

class RaceResultsViewModel: ObservableObject {

  private var apiSeasons: APISeasonsProtocol
  private let round: String
  private let year: String

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var raceModel: RaceModel?
  @Published var onDismissed: (() -> Void)?

  private var cancellable: AnyCancellable?

  init(apiSeasons: APISeasonsProtocol, round: String, year: String) {
    self.apiSeasons = apiSeasons
    self.round = round
    self.year = year
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)  }

  func fetchRaceResults() {
    if self.raceModel != nil { return }
    cancellable = apiSeasons.raceResults(round: round, year: year)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] response in
        self?.raceModel = response.table.races.first
      }
  }
}
