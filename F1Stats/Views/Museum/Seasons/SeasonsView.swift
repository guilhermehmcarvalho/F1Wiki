//
//  SeasonsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import SwiftUI

struct SeasonsView: View {
  @ObservedObject var viewModel: SeasonsViewModel

  var body: some View {
    ZStack {
      List {
        ForEach(viewModel.seasonsList) { season in
          SeasonRowView(season: season)
            .modifier(SeasonCardDisplayer(season: season))
            .onAppear() {
              viewModel.onItemDisplayed(currentItem: season)
            }
        }

        if viewModel.fetchStatus == .ongoing, !viewModel.seasonsList.isEmpty {
          ProgressView()
            .modifier(LargeProgressView())
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity)
        }
      }
      .listRowSeparator(.automatic)
      .listRowSeparatorTint(.F1Stats.appWhite)
      .scrollContentBackground(.hidden)
      .navigationTitle("Seasons")
      .onAppear(perform: viewModel.onAppear)

      if viewModel.fetchStatus == .ongoing, viewModel.seasonsList.isEmpty {
        ProgressView()
          .modifier(LargeProgressView())
          .padding(.all(32))
      }
    }
    .toastView(toast: $viewModel.errorToast)
  }
}

  #Preview {
    SeasonsView(viewModel: SeasonsViewModel(apiSeasons: APISeasonsStub(),
                                                                   wikipediaAPI: WikipediaAPIStub()))
  }
