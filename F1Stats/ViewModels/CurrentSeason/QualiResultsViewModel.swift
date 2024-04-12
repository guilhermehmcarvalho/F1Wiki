//
//  QualiResultsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 10/04/2024.
//

import Foundation
import Combine

class QualiResultsViewModel: ObservableObject {

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
      .assign(to: &$fetchStatus)
  }

  func fetchQualiResult() {
    cancellable = apiSeasons.qualifyingResults(round: round, year: year)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.raceModel = response.table.races.first
      }
  }
}
