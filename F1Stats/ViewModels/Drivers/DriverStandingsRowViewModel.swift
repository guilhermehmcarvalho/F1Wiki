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
  private let driver: DriverModel
  @Published var standingLists: [StandingsList]?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  @Published var fetchStatus: FetchStatus = .ready

  private var cancellable: AnyCancellable?

  init(driver: DriverModel, driverApi: APIDriversProtocol) {
    self.driver = driver
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
    cancellable = driverApi.listOfDriverStandings(driverId: driver.driverId)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { error in
        print(error)
      } receiveValue: { [weak self] response in
        self?.standingLists = response.table.standingsLists
      }
  }
}

extension DriverStanding {
  var constructorsAppended: String {
    self.constructors.map { $0.name }.joined(separator: ", ")
  }
}
