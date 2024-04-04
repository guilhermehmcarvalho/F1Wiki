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
  private var driverApi: APIDriversProtocol
  private var wikipediaViewModel: WikipediaViewModel
  private var driverStandingsViewModel: DriverStandingsRowViewModel

  init(driver: DriverModel, wikipediaApi: WikipediaAPIProtocol, driverApi: APIDriversProtocol) {
    self.driver = driver
    self.driverApi = driverApi
    self.wikipediaViewModel = WikipediaViewModel(url: driver.url, wikipediaApi: wikipediaApi)
    self.driverStandingsViewModel = DriverStandingsRowViewModel(driver: driver, driverApi: driverApi)
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

  var expandedView: AnyView {
    AnyView (
      VStack {
        WikipediaView(viewModel: wikipediaViewModel)
        ExpandableRow(viewModel: driverStandingsViewModel)
      }
    )
  }

  internal func onTap(isExpanded: Bool) {
    if isExpanded {
      wikipediaViewModel.fetchSummary()
    }
  }
}
