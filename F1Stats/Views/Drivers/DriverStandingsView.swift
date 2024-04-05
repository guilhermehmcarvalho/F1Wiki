//
//  DriverStandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import SwiftUI

struct DriverStandingsView: View {
  @ObservedObject var viewModel: DriverStandingsRowViewModel
  
  init(viewModel: DriverStandingsRowViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    DisclosureGroup(
      content: {
        VStack {
          HStack {
            Text("Position")
              .typography(type: .body())
              .frame(width: 80)
            Spacer()
            Text("Constructor")
              .typography(type: .body())
            Spacer()
            Text("Year")
              .frame(width: 80)
              .typography(type: .body())
          }
          .padding(.horizontal(8))

          ForEach(viewModel.standingLists ?? [], id: \.season) { season in
            if let standing = season.driverStandings?.first {
              HStack {
                Text(standing.position)
                  .typography(type: .body())
                  .frame(width: 80)
                Spacer()
                Text(standing.constructorsAppended)
                  .typography(type: .body())
                  .multilineTextAlignment(.center)
                Spacer()
                Text(season.season)
                  .frame(width: 80)
                  .typography(type: .body())

              }
              .padding(.horizontal(8))
              .padding(.vertical(2))
            }
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
        Text("Standings")
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
