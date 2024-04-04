//
//  DriverStandingsRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation
import SwiftUI
import Combine

class DriverStandingsRowViewModel: ExpandableRowViewModel, ObservableObject {
  
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

  var mainView: AnyView {
    AnyView(
      Text("Standings")
        .typography(type: .subHeader())
    )
  }

  var expandedView: AnyView {
    AnyView(
      VStack {
        if let standingLists = standingLists {
          ForEach(standingLists, id: \.season) { season in
            if let standing = season.driverStandings.first {
              HStack {
                Text(standing.position)
                  .typography(type: .body())
                  .frame(width: 30)
                Spacer()
                Text(standing.constructorsAppended)
                  .typography(type: .body())
                Spacer()
                Text(season.season)
                  .typography(type: .body())

              }
              .padding(.horizontal(8))
              .padding(.vertical(2))
            }
          }
        }

        if (fetchStatus == .ongoing) {
          AnyView(
            ProgressView()
              .padding(.all(16))
              .tint(.F1Stats.systemLight)
          )
        }
      }
    )
  }

  func onTap(isExpanded: Bool) {
    if isExpanded, standingLists == nil {
      requestStandings()
    }
  }

  private func requestStandings() {
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
