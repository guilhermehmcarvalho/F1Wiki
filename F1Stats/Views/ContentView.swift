//
//  ContentView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel: ContentViewModel

  init(viewModel: ContentViewModel) {
    self.viewModel = viewModel
    customizeTabViewAppearance()
  }

  func customizeTabViewAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = Color.F1Stats.primary.asUIColor
    UIPageControl.appearance().pageIndicatorTintColor = Color.F1Stats.primary.asUIColor.withAlphaComponent(0.5)
  }
  
  var body: some View {
    TabView {
      CurrentSeasonView(viewModel: viewModel.currentSeasonViewModel)
        .tabItem { Label("Calendar", systemImage: "calendar.circle.fill") }
        .toolbarBackground(Color.white, for: .tabBar)

      StandingsView(viewModel: viewModel.standingsViewModel)
      .tabItem { Label("Standings", systemImage: "trophy.circle.fill") }
      .toolbarBackground(Color.white, for: .tabBar)
      
      MuseumView(viewModel: viewModel.museumViewModel)
      .tabItem { Label("Museum", systemImage: "building.columns.circle.fill") }
      .toolbarBackground(Color.white, for: .tabBar)
    }
    .accentColor(.F1Stats.appWhite)
  }
}

#Preview { 
  ContentView(viewModel: ContentViewModel(apiDrivers: APIDriversStub(),
              wikipediaAPI: WikipediaAPIStub(),
              apiConstructors: APIConstructorsStub(),
              apiSeasons: APISeasonsStub(delay: 0)))
}
