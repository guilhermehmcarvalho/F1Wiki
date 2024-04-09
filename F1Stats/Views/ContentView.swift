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
    customizeNavigationStackAppearance()
  }

  func customizeNavigationStackAppearance() {
    let scrollEdgeAppearance = UINavigationBarAppearance()
    scrollEdgeAppearance.configureWithOpaqueBackground()
    scrollEdgeAppearance.backgroundColor = .clear
    scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: Color.F1Stats.systemDark.asUIColor]
    scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                     .font: UIFont.dlsFont(size: 32, weight: .heavy)]
    UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance

    let standardAppearance = UINavigationBarAppearance()
    standardAppearance.configureWithOpaqueBackground()
    standardAppearance.backgroundColor = Color.F1Stats.systemDark.asUIColor
    standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                   .font: UIFont.dlsFont(size: 32, weight: .semibold)]
    UINavigationBar.appearance().standardAppearance = standardAppearance
  }

  var body: some View {
    NavigationStack {
      ZStack {
        Color.F1Stats.systemDark.ignoresSafeArea()
        CurrentSeasonView(viewModel: CurrentSeasonViewModel(apiSeasons: apiSeasons,
//        ConstructorsView(viewModel: ConstructorsViewModel(apiConstructors: apiConstructors,
//        SeasonsView(viewModel: SeasonsViewModel(apiSeasons: apiSeasons,
//        DriversView(viewModel: DriversViewModel(driverApi: apiDrivers,
                                                          wikipediaAPI: wikipediaAPI))
      }
      .scrollContentBackground(.hidden)
    }
  }
}

#Preview {
  ContentView(apiDrivers: APIDriversStub(),
              wikipediaAPI: WikipediaAPIStub(),
              apiConstructors: APIConstructorsStub(),
              apiSeasons: APISeasonsStub())
}
