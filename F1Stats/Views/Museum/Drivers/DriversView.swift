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
    List {
      ForEach(viewModel.driverList) { driver in
        DriverRowView(driver: driver)
          .modifier(DriverCardDisplayer(driver: driver))
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
    .listRowSeparatorTint(.F1Stats.appWhite)
    .scrollContentBackground(.hidden)
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

#Preview {
  DriversView(viewModel: DriversViewModel(driverApi: APIDriversStub(),
                                          wikipediaAPI: WikipediaAPIStub()))
}
