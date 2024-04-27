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
  private var toastSubject = PassthroughSubject<Toast?, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var raceModel: RaceModel?
  @Published var onDismissed: (() -> Void)?
  @Published var errorToast: Toast?

  private var cancellable: AnyCancellable?

  init<S: PassthroughSubject<Toast?, Never>>(apiSeasons: APISeasonsProtocol, round: String, year: String, toastSubject: S? = nil) {
    self.apiSeasons = apiSeasons
    self.round = round
    self.year = year
    if let toastSubject = toastSubject {
      self.toastSubject = toastSubject
    }

    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)  }

  func fetchRaceResults() {
    if self.raceModel != nil { return }
    cancellable = apiSeasons.raceResults(round: round, year: year)
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] finished in
        switch finished {
        case .failure(_):
          self?.onDismissed?()
        default: break
        }
      } receiveValue: { [weak self] response in
        self?.raceModel = response.table.races.first
      }
  }
}
