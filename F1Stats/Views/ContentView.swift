//
//  ContentView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import SwiftUI

struct ContentView: View {

  let apiDrivers: APIDriversProtocol

//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }

  var body: some View {
    DriversView(driversViewModel: DriversViewModel(driverApi: apiDrivers))
  }
}

#Preview {
    ContentView(apiDrivers: MockAPIDrivers())
}
