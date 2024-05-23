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

  let apiDrivers = APIDrivers(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession)
  let apiConstructors = APIConstructors(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession)
  let wikipediaAPI = WikipediaAPI(baseURL: Config.wikipediaURL, urlSession: URLSessionManager.urlSession)
  let apiSeasons = APISeasons(baseURL: Config.baseURL, urlSession: URLSessionManager.urlSession)

  init() {
    customizeTabViewAppearance()
  }

  func customizeTabViewAppearance() {
    UIPageControl.appearance().currentPageIndicatorTintColor = Color.F1Stats.primary.asUIColor
    UIPageControl.appearance().pageIndicatorTintColor = Color.F1Stats.primary.asUIColor.withAlphaComponent(0.5)
  }

  var body: some Scene {
    WindowGroup {
      ZStack {
//				Text("drivers \(drivers.count)")
//					.typography(type: .heading())

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
		.modelContainer(for: Driver.self) { result in
				do {
						let container = try result.get()

						// Check we haven't already added our users.
						let descriptor = FetchDescriptor<Driver>()
						let existingItems = try container.mainContext.fetchCount(descriptor)
						guard existingItems == 0 else { return }

						// Load and decode the JSON.
						guard let url = Bundle.main.url(forResource: "drivers", withExtension: "json") else {
								fatalError("Failed to find drivers.json")
						}

						let data = try Data(contentsOf: url)
						let items = try JSONDecoder().decode([Driver].self, from: data)

						// Add all our data to the context.
						for item in items {
								container.mainContext.insert(item)
						}
				} catch let error  {
						print("Failed to pre-seed database.", error)
				}
		}
  }
}
