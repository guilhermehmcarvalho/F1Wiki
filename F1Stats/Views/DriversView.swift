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
    List(driversViewModel.driverList) { driver in
      HStack {
        Text(driver.familyName).foregroundStyle(.black, .red)
          .onAppear() {
            driversViewModel.onItemDisplayed(currentItem: driver)
          }
      }
    }
    .onAppear(perform: {
      driversViewModel.fetchDrivers()
    })
  }

}

#Preview {
  DriversView(driversViewModel: DriversViewModel(driverApi: MockAPIDrivers()))
}
