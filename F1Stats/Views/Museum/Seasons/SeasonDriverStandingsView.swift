//
//  SeasonDriverStandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import SwiftUI

struct SeasonDriverStandingsView: View {
  @ObservedObject var viewModel: SeasonDriverStandingsViewModel

  init(viewModel: SeasonDriverStandingsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    DisclosureGroup(
      content: {
        VStack {
          HStack {
            HStack {
              Text("")
                .frame(width: 30)
              Text("Driver")
                .typography(type: .body())
              Spacer()
              Text("Constructor")
                .typography(type: .body())
            }
          }
          .padding(.horizontal(8))

          ForEach(viewModel.standingLists?.first?.driverStandings ?? [], id: \.driver) { standing in
            HStack {
              Text(standing.position)
                .typography(type: .body())
                .frame(width: 30)
              Text(standing.driver.fullName)
                .typography(type: .body())
              Spacer()
              Text(standing.constructorsAppended)
                .typography(type: .body())

            }
            .padding(.horizontal(8))
            .padding(.vertical(2))
          }

          if (viewModel.fetchStatus == .ongoing) {
            ProgressView()
              .tint(.F1Stats.appWhite)
          }
        }
        .padding(.vertical(8))
        .frame(maxWidth: .infinity)
        .background(Color.F1Stats.appWhite.opacity(0.1))
      },
      label: {
        Text("Driver standings")
          .typography(type: .subHeader())
      }
    )
    .listRowInsets(.all(0))
    .disclosureGroupStyle(
      CustomDisclosureGroupStyle(onTap: viewModel.onTap(isExpanded:))
    )
    .listRowBackground(
      Color.F1Stats.appDarkSecondary
    )
  }
}
