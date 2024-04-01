//
//  F1StatsApp.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI

@main
struct F1StatsApp: App {
  let apiDrivers =  APIDrivers(baseURL: Config.baseURL)

    var body: some Scene {
        WindowGroup {
          ContentView(apiDrivers: apiDrivers)
        }
    }
}
