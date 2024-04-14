//
//  StandingsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import Foundation
import Combine

class StandingsViewModel: ObservableObject {
  let apiSeasons: APISeasonsProtocol

  @Published var selectedTab: Int = 0

  internal let tabItems: [String] = ["Drivers", "Constructors"]

  let driverStandingsViewModel: DriverStandingsViewModel
  let constructorStandingsViewModel: ConstructorStandingsViewModel

  init(apiSeasons: APISeasonsProtocol) {
    self.apiSeasons = apiSeasons
    driverStandingsViewModel = DriverStandingsViewModel(apiSeasons: apiSeasons)
    constructorStandingsViewModel = ConstructorStandingsViewModel(apiSeasons: apiSeasons)
  }
}
