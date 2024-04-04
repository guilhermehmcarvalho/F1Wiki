//
//  DriverRowView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import SwiftUI

struct DriverRowView: View {
  @ObservedObject var viewModel: DriverRowViewModel

  init(viewModel: DriverRowViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    DisclosureGroup(
      content: {
        VStack {
          WikipediaView(viewModel: viewModel.wikipediaViewModel)
          DriverStandingsView(viewModel: viewModel.driverStandingsViewModel)
        }
          .frame(maxWidth: .infinity)
        .background(Color.F1Stats.systemWhite.opacity(0.1))
      },
      label: {
        VStack(alignment: .leading, spacing: 0) {
              HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(viewModel.driver.familyName)
                  .textCase(.uppercase)
                  .typography(type: .heading())
                Text(viewModel.driver.givenName)
                  .typography(type: .small())
                Spacer()
              }
              AnyView(
                Text(viewModel.driver.nationality)
                  .typography(type: .small())
              )
            }

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
