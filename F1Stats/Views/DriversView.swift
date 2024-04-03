//
//  DriversView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 01/04/2024.
//

import SwiftUI

struct DriversView: View {
  @ObservedObject var driversViewModel: DriversViewModel

  var body: some View {
    NavigationStack {
      List(driversViewModel.driverList) { driver in
        DriverRow(driver: driver)
          .frame(height: 40)
          .padding(EdgeInsets.all(0) )
          .listRowSeparator(.hidden)
          .onAppear() {
            driversViewModel.onItemDisplayed(currentItem: driver)
          }
      }
      .navigationTitle("Drivers")
      .onAppear(perform: {
        driversViewModel.fetchDrivers()
      })
    }
  }
}

#Preview {
  DriversView(driversViewModel: DriversViewModel(driverApi: MockAPIDrivers()))
}
