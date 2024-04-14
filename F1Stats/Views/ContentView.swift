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

//    customizeNavigationStackAppearance()
    customizeTabViewAppearance()
  }

//  func customizeNavigationStackAppearance() {
//    let scrollEdgeAppearance = UINavigationBarAppearance()
//    scrollEdgeAppearance.configureWithOpaqueBackground()
//    scrollEdgeAppearance.backgroundColor = .clear
//    scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: Color.F1Stats.systemDark.asUIColor]
//    scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
//                                                     .font: UIFont.dlsFont(size: 32, weight: .heavy)]
//    UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
//
//    let standardAppearance = UINavigationBarAppearance()
//    standardAppearance.configureWithOpaqueBackground()
//    standardAppearance.backgroundColor = Color.F1Stats.systemDark.asUIColor
//    standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
//                                                   .font: UIFont.dlsFont(size: 32, weight: .semibold)]
//    UINavigationBar.appearance().standardAppearance = standardAppearance
//  }

  func customizeTabViewAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = Color.F1Stats.primary.asUIColor
    UIPageControl.appearance().pageIndicatorTintColor = Color.F1Stats.systemWhite.asUIColor.withAlphaComponent(0.8)
  }

  var body: some View {
    TabView {
      CurrentSeasonView(viewModel: CurrentSeasonViewModel(apiSeasons: apiSeasons))
        .tabItem { Label("Calendar", systemImage: "calendar.circle.fill") }
        .toolbarBackground(Color.white, for: .tabBar)

      MuseumView(viewModel: MuseumViewModel( apiSeasons: apiSeasons,
                                             wikipediaAPI: wikipediaAPI,
                                             driverAPI: apiDrivers,
                                             constructorsAPI: apiConstructors))
      .tabItem { Label("Museum", systemImage: "trophy.circle.fill") }
      .toolbarBackground(Color.white, for: .tabBar)
    }
    .accentColor(.F1Stats.systemWhite)
  }
}

#Preview { 
  ContentView(apiDrivers: APIDriversStub(),
              wikipediaAPI: WikipediaAPIStub(),
              apiConstructors: APIConstructorsStub(),
              apiSeasons: APISeasonsStub(delay: 1))
}
