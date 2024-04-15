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
  let apiDrivers: APIDriversProtocol
  let wikipediaAPI: WikipediaAPIProtocol

  @Published var selectedTab: Int = 0

  internal let tabItems: [String] = ["Drivers", "Constructors"]

  let driverStandingsViewModel: DriverStandingsViewModel
  let constructorStandingsViewModel: ConstructorStandingsViewModel

  init(apiSeasons: APISeasonsProtocol,
       apiDrivers: APIDriversProtocol,
       wikipediaAPI: WikipediaAPIProtocol) {
    self.apiSeasons = apiSeasons
    self.apiDrivers = apiDrivers
    self.wikipediaAPI = wikipediaAPI
    driverStandingsViewModel = DriverStandingsViewModel(apiSeasons: apiSeasons,
                                                        apiDriver: apiDrivers,
                                                        wikipediaAPI: wikipediaAPI)
    constructorStandingsViewModel = ConstructorStandingsViewModel(apiSeasons: apiSeasons)
  }
}
