//
//  MuseumViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 13/04/2024.
//

import Foundation
import Combine

class MuseumViewModel: ObservableObject {

  let apiSeasons: APISeasonsProtocol
  let wikipediaAPI: WikipediaAPIProtocol
  let driverAPI: APIDriversProtocol
  let constructorsAPI: APIConstructorsProtocol
  
  @Published var seasonsViewModel: SeasonsViewModel
  @Published var driversViewModel: DriversViewModel
  @Published var constructorsViewModel : ConstructorsViewModel

  @Published var selectedTab: Int = 0

  init(apiSeasons: APISeasonsProtocol, wikipediaAPI: WikipediaAPIProtocol, driverAPI: APIDriversProtocol, constructorsAPI: APIConstructorsProtocol) {
    self.apiSeasons = apiSeasons
    self.wikipediaAPI = wikipediaAPI
    self.driverAPI = driverAPI
    self.constructorsAPI = constructorsAPI

    self.seasonsViewModel = SeasonsViewModel(apiSeasons: apiSeasons, wikipediaAPI: wikipediaAPI)
    self.driversViewModel =  DriversViewModel(driverApi: driverAPI, wikipediaAPI: wikipediaAPI)
    self.constructorsViewModel = ConstructorsViewModel(apiConstructors: constructorsAPI, wikipediaAPI: wikipediaAPI)
  }
}
