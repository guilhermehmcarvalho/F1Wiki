//
//  ExpandableRow.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import SwiftUI

struct ExpandableRow<ViewModel>: View where ViewModel: ExpandableRowViewModel {

  @ObservedObject var viewModel: ViewModel
  @State private var arrowRotation: Double = 0

  var body: some View {
    DisclosureGroup(
      content: { viewModel.expandedView
          .frame(maxWidth: .infinity)
      },
      label: { viewModel.mainView
          .padding(.horizontal(16))
          .padding(.vertical(8))
      }
    )
    .disclosureGroupStyle(
      CustomDisclosureGroupStyle(button: Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.systemLight), onTap: viewModel.onTap)
    )
    .listRowInsets(.all(0))
    .listRowBackground(
      RoundedRectangle(cornerRadius: 8)
        .foregroundColor(.clear)
        .background(Color.clear)
    )
    .background(background)
  }

  var background: some View {
    RoundedRectangle(cornerRadius: 5)
      .foregroundColor(Color.F1Stats.systemDarkSecondary)
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
