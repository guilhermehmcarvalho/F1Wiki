//
//  SeasonRowView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import SwiftUI

struct SeasonRowView: View {
  @ObservedObject var viewModel: SeasonRowViewModel

  init(viewModel: SeasonRowViewModel) {
    self.viewModel = viewModel
  }

  var label: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .firstTextBaseline, spacing: 4) {
        Text(viewModel.season.season)
          .textCase(.uppercase)
          .typography(type: .heading())
        Spacer()
      }
    }
  }

  var content: some View {
    VStack {
      WikipediaView(viewModel: viewModel.wikipediaViewModel)
        .padding(.vertical(8))

      SeasonDriverStandingsView(viewModel: viewModel.seasonDriverStandingsViewModel)
        .padding(.vertical(8))

      if Int(viewModel.season.season) ?? 0 >= 1958 {
        SeasonConstructorStandingsView(viewModel: viewModel.seasonConstructorStandingsViewModel)
          .padding(.vertical(8))
      }
    }
    .frame(maxWidth: .infinity)
    .background(Color.F1Stats.appWhite.opacity(0.1))
  }

  var body: some View {
    DisclosureGroup(
      content: { self.content },
      label: { self.label }
    )
    .listRowInsets(.all(0))
    .disclosureGroupStyle(
      CustomDisclosureGroupStyle()
    )
    .listRowBackground(
      Color.F1Stats.appDarkSecondary
    )
  }
}
