//
//  DriversView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 01/04/2024.
//

import SwiftUI

struct DriversView: View {
  @ObservedObject var viewModel: DriversViewModel

  var body: some View {
    ZStack {
      List(viewModel.driverList) { driver in
        ExpandableRow(viewModel: DriverRowViewModel(driver: driver, wikipediaApi: viewModel.wikipediaAPI))
          .padding(.vertical(4))
          .listRowSeparator(.hidden)
          .onAppear() {
            viewModel.onItemDisplayed(currentItem: driver)
          }
      }
      .scrollContentBackground(.hidden)
      .navigationTitle("Drivers")
      .onAppear(perform: {
        viewModel.fetchDrivers()
      })
    }
  }
}

#Preview {
  DriversView(viewModel: DriversViewModel(driverApi: APIDriversStub(),
                                          wikipediaAPI: WikipediaAPIStub()))
}
