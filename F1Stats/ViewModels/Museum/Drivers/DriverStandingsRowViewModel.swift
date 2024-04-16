//
//  DriverStandingsRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation
import SwiftUI
import Combine

class DriverStandingsRowViewModel: ObservableObject {
  
  private var driverApi: APIDriversProtocol
  private let driverId: String
  @Published var standingLists: [StandingsList]?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  @Published var fetchStatus: FetchStatus = .ready

  private var cancellable: AnyCancellable?

  init(driverId: String, driverApi: APIDriversProtocol) {
    self.driverId = driverId
    self.driverApi = driverApi
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
    cancellable = driverApi.listOfDriverStandings(driverId: driverId)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      }  receiveValue: { [weak self] response in
        self?.standingLists = response.table.standingsLists
      }
  }
}
