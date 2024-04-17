//
//  ContentViewModel.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 17/04/2024.
//

import Foundation


class ContentViewModel: ObservableObject {

  let apiDrivers: APIDriversProtocol
  let apiConstructors: APIConstructorsProtocol
  let apiSeasons: APISeasonsProtocol
  let wikipediaAPI: WikipediaAPIProtocol

  let currentSeasonViewModel: CurrentSeasonViewModel
  let museumViewModel: MuseumViewModel
  let standingsViewModel: StandingsViewModel

  init(apiDrivers: APIDriversProtocol,
       wikipediaAPI: WikipediaAPIProtocol,
       apiConstructors: APIConstructorsProtocol,
       apiSeasons: APISeasonsProtocol) {
    self.apiDrivers = apiDrivers
    self.wikipediaAPI = wikipediaAPI
    self.apiConstructors = apiConstructors
    self.apiSeasons = apiSeasons
    
    currentSeasonViewModel = CurrentSeasonViewModel(apiSeasons: apiSeasons)
    standingsViewModel = StandingsViewModel(apiSeasons:
                                              apiSeasons,
                                            apiDrivers: apiDrivers,
                                            wikipediaAPI: wikipediaAPI)
    museumViewModel = MuseumViewModel(apiSeasons: apiSeasons,
                                      wikipediaAPI: wikipediaAPI,
                                      driverAPI: apiDrivers,
                                      constructorsAPI: apiConstructors)
  }

}
