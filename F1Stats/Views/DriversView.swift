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
      List(viewModel.driverList) { driver in
        ExpandableRow(viewModel: DriverRowViewModel(driver: driver, wikipediaApi: viewModel.wikipediaAPI)
        )
          .padding(.vertical(4))
          .onAppear() {
            viewModel.onItemDisplayed(currentItem: driver)
          }
      }
      .listRowSeparator(.visible)
      .listRowSeparatorTint(.F1Stats.systemWhite)
      .scrollContentBackground(.hidden)
      .navigationTitle("Drivers")
      .onAppear(perform: {
        viewModel.fetchDrivers()
      })
  }
}

#Preview {
  DriversView(viewModel: DriversViewModel(driverApi: APIDriversStub(),
                                          wikipediaAPI: WikipediaAPIStub()))
}
