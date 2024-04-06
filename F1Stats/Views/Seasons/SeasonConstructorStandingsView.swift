//
//  SeasonConstructorStandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import SwiftUI

struct SeasonConstructorStandingsView: View {
  @ObservedObject var viewModel: SeasonConstructorStandingsViewModel

  init(viewModel: SeasonConstructorStandingsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    DisclosureGroup(
      content: {
        VStack {
          HStack {
            Text("Position")
              .frame(width: 150)
              .typography(type: .body())
            Spacer()
            Text("Year")
              .frame(width: 150)
              .typography(type: .body())

          }
          .padding(.horizontal(8))
          .padding(.vertical(2))

          ForEach(viewModel.standingLists?.first?.constructorStanding ?? [], id: \.constructor) { standing in
            HStack {
              Text(standing.position)
                .typography(type: .body())
                .frame(width: 150)
              Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .overlay(Color.F1Stats.systemWhite)
              Text(standing.constructor.name)
                .frame(width: 150)
                .typography(type: .body())

            }
            .padding(.horizontal(8))
            .padding(.vertical(2))
          }

          if (viewModel.fetchStatus == .ongoing) {
            ProgressView()
              .tint(.F1Stats.systemLight)
          }
        }
        .padding(.vertical(8))
        .frame(maxWidth: .infinity)
        .background(Color.F1Stats.systemWhite.opacity(0.1))
      },
      label: {
        Text("Constructor standings")
          .typography(type: .subHeader())
      }
    )
    .listRowInsets(.all(0))
    .disclosureGroupStyle(
      CustomDisclosureGroupStyle(onTap: viewModel.onTap(isExpanded:))
    )
    .listRowBackground(
      Color.F1Stats.systemDarkSecondary
    )
  }
}
