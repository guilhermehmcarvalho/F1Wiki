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
    ZStack {
      List(driversViewModel.driverList) { driver in
        DriverRow(driver: driver)
          .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0) )
          .listRowSeparator(.hidden)
          .onAppear() {
            driversViewModel.onItemDisplayed(currentItem: driver)
          }
      }
      .scrollContentBackground(.hidden)
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
