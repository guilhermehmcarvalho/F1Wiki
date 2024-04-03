//
//  ExpandableRow.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import SwiftUI

struct ExpandableRow<ViewModel>: View where ViewModel: ExpandableRowViewModel {

  @ObservedObject var viewModel: ViewModel

  var body: some View {
    DisclosureGroup(
      content: { viewModel.expandedView
          .frame(maxWidth: .infinity)
        .background(Color.F1Stats.systemWhite.opacity(0.1))
      },
      label: { viewModel.mainView
          .padding(.horizontal(16))
          .padding(.vertical(8))
      }
    )
    .listRowInsets(.all(0))
    .disclosureGroupStyle(
      CustomDisclosureGroupStyle(button: Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.systemLight), onTap: viewModel.onTap)
    )
    .listRowBackground(
      Color.F1Stats.systemDarkSecondary
    )
  }
}

struct CustomDisclosureGroupStyle<Label: View>: DisclosureGroupStyle {
  let button: Label
  let onTap: ((Bool) -> ())?

  func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .center, spacing: 0) {
      configuration.label
      Spacer()
      button
        .padding(.horizontal(16))
        .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
    }
    .listRowSeparator(configuration.isExpanded ? .hidden : .automatic)
    .listRowSeparatorTint(.F1Stats.systemLight)
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        configuration.isExpanded.toggle()
      }
      onTap?(configuration.isExpanded)
    }

    if configuration.isExpanded {
      configuration.content
        .disclosureGroupStyle(self)
    }
  }
}

#Preview {
  ExpandableRow(viewModel: DriverRowViewModel.stub)
}
