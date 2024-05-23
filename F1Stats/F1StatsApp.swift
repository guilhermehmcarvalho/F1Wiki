//
//  F1StatsApp.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI
import SwiftData

@main
struct F1StatsApp: App {

  @State private var animationComplete = false

	let apiDrivers: APIDriversProtocol
//  let apiDrivers = APIDrivers(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession)
  let apiConstructors = APIConstructors(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession)
  let wikipediaAPI = WikipediaAPI(baseURL: Config.wikipediaURL, urlSession: URLSessionManager.urlSession)
  let apiSeasons = APISeasons(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession)
	var container: ModelContainer

  init() {
		self.container = ContainerFactory.makeContainer()
		apiDrivers = LocalDriversAPI(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession, modelContext: container.mainContext)

		#if DEBUG
		ContainerPopulator(modelContext: container.mainContext)
			.populateDB()
		#endif

		customizeTabViewAppearance()
  }

  func customizeTabViewAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = Color.F1Stats.primary.asUIColor
    UIPageControl.appearance().pageIndicatorTintColor = Color.F1Stats.primary.asUIColor.withAlphaComponent(0.5)
  }

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
		.modelContainer(container)
  }
}
