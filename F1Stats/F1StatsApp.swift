//
//  F1StatsApp.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI

@main
struct F1StatsApp: App {
  let apiDrivers = APIDrivers(baseURL: Config.baseURL)
  let apiConstructors = APIConstructors(baseURL: Config.baseURL)
  let wikipediaAPI = WikipediaAPI(baseURL: Config.wikipediaURL)
  let apiSeasons = APISeasons(baseURL: Config.baseURL)

  var body: some Scene {
    WindowGroup {
      ContentView(apiDrivers: apiDrivers,
                  wikipediaAPI: wikipediaAPI,
                  apiConstructors: apiConstructors,
                  apiSeasons: apiSeasons)
    }
  }
}
