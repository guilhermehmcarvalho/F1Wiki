//
//  ExpandableRow.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import SwiftUI

struct ExpandableRow<ViewModel>: View where ViewModel: ExpandableRowViewModel {

  @ObservedObject var viewModel: ViewModel

  var header: some View {
    HStack(alignment: .center, spacing: 0) {
      viewModel.mainView
      Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.systemLight)
    }
    .padding(.horizontal(16))
    .padding(.vertical(8))
    .background(background)
  }

  var body: some View {
    VStack(spacing: 0) {
      header
      viewModel.expandedView
    }
    .onTapGesture {
      viewModel.onTap()
    }
    .listRowInsets(.all(0))
    .listRowBackground(
      RoundedRectangle(cornerRadius: 5)
        .foregroundColor(.clear)
        .background(Color.clear)
    )
  }

  var background: some View {
    RoundedRectangle(cornerRadius: 5)
      .foregroundColor(Color.F1Stats.systemDarkSecondary)
  }
}

#Preview {
  ExpandableRow(viewModel: DriverRowViewModel.stub)
}
