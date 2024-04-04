//
//  DriverRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI
import Combine

class DriverRowViewModel: ExpandableRowViewModel, ObservableObject {
  private let driver: DriverModel
  private let wikipediaApi: WikipediaAPIProtocol
  private var driverApi: APIDriversProtocol
  @Published var expandedView: AnyView = AnyView(Group{})
  @Published var wikipediaData: WikipediaSummaryModel?
  private var cancellable: AnyCancellable?

  init(driver: DriverModel, wikipediaApi: WikipediaAPIProtocol, driverApi: APIDriversProtocol) {
    self.driver = driver
    self.wikipediaApi = wikipediaApi
    self.driverApi = driverApi
  }

  var mainView: AnyView {
    AnyView(
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
          Text(driver.familyName)
            .textCase(.uppercase)
            .typography(type: .heading())
          Text(driver.givenName)
            .typography(type: .small())
          Spacer()
        }
        AnyView(
          Text(driver.nationality)
            .typography(type: .small())
        )
      }
    )
  }

  internal func onTap(isExpanded: Bool) {
    if isExpanded, wikipediaData == nil {
      requestSummary()
    }

    setExpandedView()
  }

  private func setExpandedView() {
    if let wikipediaData = wikipediaData {
      expandedView = AnyView(
        VStack {
          WikipediaView(
            wikipediaViewModel: WikipediaViewModel(fromSummary: wikipediaData)
          )
          .padding(.all(16))

          ExpandableRow(
            viewModel: DriverStandingsRowViewModel(driver: driver,
                                                               driverApi: driverApi)
          )
          .padding(.vertical(8))
        }
      )
    }
    else {
      expandedView = AnyView(
        ProgressView()
          .padding(.all(16))
          .tint(.F1Stats.systemLight)
      )
    }
  }

  private func requestSummary() {
    cancellable = wikipediaApi.getSummaryFor(url: driver.url)
      .receive(on: DispatchQueue.main)
      .sink { error in
        print(error)
      } receiveValue: { [weak self] response in
        self?.wikipediaData = response
        self?.setExpandedView()
      }
  }

}

extension DriverRowViewModel {
  static var stub = DriverRowViewModel(driver: DriverModel.stub, 
                                       wikipediaApi: WikipediaAPIStub(),
  driverApi: APIDriversStub())
}
