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
          if let standingLists = viewModel.standingLists {
            ForEach(standingLists, id: \.season) { season in
              if let standing = season.driverStandings.first {
                HStack {
                  Text(standing.position)
                    .typography(type: .body())
                    .frame(width: 30)
                  Spacer()
                  Text(standing.constructorsAppended)
                    .typography(type: .body())
                  Spacer()
                  Text(season.season)
                    .typography(type: .body())
                  
                }
                .padding(.horizontal(8))
                .padding(.vertical(2))
              }
            }
          }
          
          if (viewModel.fetchStatus == .ongoing) {
            ProgressView()
              .padding(.all(16))
              .tint(.F1Stats.systemLight)
          }
        }
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
      CustomDisclosureGroupStyle(button: Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.systemLight),
                                 onTap: viewModel.onTap(isExpanded:))
    )
    .listRowBackground(
      Color.F1Stats.systemDarkSecondary
    )
  }
}
