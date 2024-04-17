//
//  F1StatsApp.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI

@main
struct F1StatsApp: App {

  @State private var animationComplete = false

  let apiDrivers = APIDrivers(baseURL: Config.baseURL)
  let apiConstructors = APIConstructors(baseURL: Config.baseURL)
  let wikipediaAPI = WikipediaAPI(baseURL: Config.wikipediaURL)
  let apiSeasons = APISeasons(baseURL: Config.baseURL)

  var body: some Scene {
    WindowGroup {
      ZStack {
        if (animationComplete == false) {
          SplashScreen(animationComplete: $animationComplete)
        } else {
          ContentView(viewModel: ContentViewModel(apiDrivers: apiDrivers,
                                                   wikipediaAPI: wikipediaAPI,
                                                   apiConstructors: apiConstructors,
                                                   apiSeasons: apiSeasons))
        }
      }
    }
  }
}
