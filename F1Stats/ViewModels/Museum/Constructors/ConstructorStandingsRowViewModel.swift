//
//  ConstructorStandingsRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation
import Combine

class ConstructorStandingsRowViewModel: ObservableObject {

  private var apiConstructors: APIConstructorsProtocol
  private let constructorId: String
  @Published var standingLists: [StandingsList]?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  @Published var fetchStatus: FetchStatus = .ready

  private var cancellable: AnyCancellable?

  init(constructorId: String, apiConstructors: APIConstructorsProtocol) {
    self.constructorId = constructorId
    self.apiConstructors = apiConstructors
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)  }

  func onTap(isExpanded: Bool) {
    if isExpanded, standingLists == nil {
      fetchStandings()
    }
  }

  internal func fetchStandings() {
    cancellable = apiConstructors.listOfConstructorStandings(constructorId: constructorId)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in }  receiveValue: { [weak self] response in
        self?.standingLists = response.table.standingsLists
      }
  }
}
