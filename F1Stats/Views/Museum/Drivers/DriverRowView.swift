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

  var label: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .firstTextBaseline, spacing: 4) {
        Text(viewModel.driver.familyName)
          .textCase(.uppercase)
          .typography(type: .heading())
        Text(viewModel.driver.givenName)
          .typography(type: .small())
        Spacer()
      }
      Text(viewModel.driver.nationality)
        .typography(type: .small())
    }
  }

  var content: some View {
    VStack {
      WikipediaView(viewModel: viewModel.wikipediaViewModel)
        .padding(.vertical(8))
      DriverStandingsRowView(viewModel: viewModel.driverStandingsViewModel)
        .padding(.vertical(8))
    }
    .frame(maxWidth: .infinity)
    .background(Color.F1Stats.systemWhite.opacity(0.1))
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
      Color.F1Stats.systemDarkSecondary
    )
  }

}
