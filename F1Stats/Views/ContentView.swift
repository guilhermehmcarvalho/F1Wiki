//
//  ContentView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI

struct ContentView: View {

  let apiDrivers: APIDriversProtocol
  let apiConstructors: APIConstructorsProtocol
  let apiSeasons: APISeasonsProtocol
  let wikipediaAPI: WikipediaAPIProtocol

  init(apiDrivers: APIDriversProtocol,
       wikipediaAPI: WikipediaAPIProtocol,
       apiConstructors: APIConstructorsProtocol,
       apiSeasons: APISeasonsProtocol) {
    self.apiDrivers = apiDrivers
    self.wikipediaAPI = wikipediaAPI
    self.apiConstructors = apiConstructors
    self.apiSeasons = apiSeasons

    customizeTabViewAppearance()
  }

  func customizeTabViewAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = Color.F1Stats.primary.asUIColor
    UIPageControl.appearance().pageIndicatorTintColor = Color.F1Stats.primary.asUIColor.withAlphaComponent(0.5)
  }

  var body: some View {
    TabView {
      CurrentSeasonView(viewModel: CurrentSeasonViewModel(apiSeasons: apiSeasons))
        .tabItem { Label("Calendar", systemImage: "calendar.circle.fill") }
        .toolbarBackground(Color.white, for: .tabBar)

      StandingsView(viewModel: StandingsViewModel(apiSeasons: apiSeasons,
                                                  apiDrivers: apiDrivers,
                                                  wikipediaAPI: wikipediaAPI))
      .tabItem { Label("Standings", systemImage: "trophy.circle.fill") }
      .toolbarBackground(Color.white, for: .tabBar)

      MuseumView(viewModel: MuseumViewModel(apiSeasons: apiSeasons,
                                            wikipediaAPI: wikipediaAPI,
                                            driverAPI: apiDrivers,
                                            constructorsAPI: apiConstructors))
      .tabItem { Label("Museum", systemImage: "building.columns.circle.fill") }
      .toolbarBackground(Color.white, for: .tabBar)
    }
    .accentColor(.F1Stats.appWhite)
  }
}

#Preview { 
  ContentView(apiDrivers: APIDriversStub(),
              wikipediaAPI: WikipediaAPIStub(),
              apiConstructors: APIConstructorsStub(),
              apiSeasons: APISeasonsStub(delay: 1))
}
