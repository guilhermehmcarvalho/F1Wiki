//
//  DriverRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI
import Combine

class DriverRowViewModel: ObservableObject {
  internal let driver: DriverModel
  private var driverApi: APIDriversProtocol
  @Published internal var wikipediaViewModel: WikipediaViewModel
  
  internal var driverStandingsViewModel: DriverStandingsRowViewModel {
    DriverStandingsRowViewModel(driver: driver, driverApi: driverApi)
  }

  init(driver: DriverModel, wikipediaApi: WikipediaAPIProtocol, driverApi: APIDriversProtocol) {
    self.driver = driver
    self.driverApi = driverApi
    self.wikipediaViewModel = WikipediaViewModel(url: driver.url, wikipediaApi: wikipediaApi)
  }
  
  internal func onTap(isExpanded: Bool) {
    if isExpanded {
      wikipediaViewModel.fetchSummary()
    }
  }
}
