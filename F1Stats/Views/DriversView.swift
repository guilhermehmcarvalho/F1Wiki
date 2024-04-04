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
      List {
        ForEach(viewModel.driverList) { driver in
          DriverRowView(viewModel: viewModel.driverRoleViewModel(for: driver))
          .padding(.vertical(4))
          .onAppear() {
            viewModel.onItemDisplayed(currentItem: driver)
          }
        }

        if viewModel.fetchStatus == .ongoing, !viewModel.driverList.isEmpty {
          ProgressView()
            .modifier(LargeProgressView())
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
        }
      }
      .listRowSeparator(.automatic)
      .listRowSeparatorTint(.F1Stats.systemWhite)
      .scrollContentBackground(.hidden)
      .navigationTitle("Drivers")
      .onAppear(perform: {
        viewModel.fetchDrivers()
      })

      if viewModel.fetchStatus == .ongoing, viewModel.driverList.isEmpty {
        ProgressView()
          .modifier(LargeProgressView())
          .padding(.all(32))
      }
    }
  }
}

#Preview {
  DriversView(viewModel: DriversViewModel(driverApi: APIDriversStub(),
                                          wikipediaAPI: WikipediaAPIStub()))
}
