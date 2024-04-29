//
//  SeasonCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI

struct SeasonCardView: View {

  @ObservedObject var viewModel: SeasonCardViewModel

  init(viewModel: SeasonCardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    VStack {
      SeasonMainCardView(viewModel: viewModel.wikipediaViewModel)
        .padding(.all(16))
        .scalingTransition()

      SeasonDriverStandingsCardView(viewModel: viewModel.seasonDriverStandingsViewModel)
        .padding(.all(16))
        .scalingTransition()

      SeasonConstructorStandingsCardView(viewModel: viewModel.seasonConstructorStandingsViewModel)
        .padding(.all(16))
        .scalingTransition()

        .safeAreaPadding(.top)
    }

    .toastView(toast: $viewModel.seasonConstructorStandingsViewModel.errorToast)
    .toastView(toast: $viewModel.seasonDriverStandingsViewModel.errorToast)
    .toastView(toast: $viewModel.wikipediaViewModel.errorToast)
  }
}

#Preview {
  SeasonCardView(viewModel: SeasonCardViewModel(season: SeasonModel(season: "1989", url: "https://en.wikipedia.org/wiki/2021_Formula_One_World_Championship"),
                                                wikipediaApi: WikipediaAPIStub(),
                                                apiSeason: APISeasonsStub(error: .invalidResponse)))
}
