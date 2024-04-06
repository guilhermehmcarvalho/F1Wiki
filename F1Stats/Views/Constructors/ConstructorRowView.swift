//
//  ConstructorRowView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import SwiftUI

struct ConstructorRowView: View {
  @ObservedObject var viewModel: ConstructorRowViewModel

  init(viewModel: ConstructorRowViewModel) {
    self.viewModel = viewModel
  }

  var label: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .firstTextBaseline, spacing: 4) {
        Text(viewModel.constructor.name)
          .textCase(.uppercase)
          .typography(type: .heading())
        Spacer()
      }
      Text(viewModel.constructor.nationality)
        .typography(type: .small())
    }
  }

  var content: some View {
    VStack {
      WikipediaView(viewModel: viewModel.wikipediaViewModel)
        .padding(.vertical(8))
      ConstructorStandingsRowView(viewModel: viewModel.constructorStandingsRowViewModel)
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
      CustomDisclosureGroupStyle(onTap: viewModel.onTap(isExpanded:))
    )
    .listRowBackground(
      Color.F1Stats.systemDarkSecondary
    )
  }

}
