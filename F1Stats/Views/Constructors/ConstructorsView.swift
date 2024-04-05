//
//  ConstructorsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import SwiftUI

struct ConstructorsView: View {
  @ObservedObject var viewModel: ConstructorsViewModel

  var body: some View {
    ZStack {
      List {
        ForEach(viewModel.constructorsList) { constructor in
          Text(constructor.name)
            .padding(.vertical(4))
            .onAppear() {
              viewModel.onItemDisplayed(currentItem: constructor)
            }
        }

        if viewModel.fetchStatus == .ongoing, !viewModel.constructorsList.isEmpty {
          ProgressView()
            .modifier(LargeProgressView())
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
        }
      }
      .listRowSeparator(.automatic)
      .listRowSeparatorTint(.F1Stats.systemWhite)
      .scrollContentBackground(.hidden)
      .navigationTitle("Constructors")
      .onAppear(perform: {
        viewModel.fetchDrivers()
      })

      if viewModel.fetchStatus == .ongoing, viewModel.constructorsList.isEmpty {
        ProgressView()
          .modifier(LargeProgressView())
          .padding(.all(32))
      }
    }
  }
}

#Preview {
  ConstructorsView(viewModel: ConstructorsViewModel(apiConstructors: APIConstructorsStub(),
                                                    wikipediaAPI: WikipediaAPIStub()))
}
