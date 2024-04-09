//
//  CustomDisclosureGroupStyle.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation
import SwiftUI

struct CustomDisclosureGroupStyle: DisclosureGroupStyle {
  let onTap: ((Bool) -> ())?

  init(onTap: ((Bool) -> Void)? = nil) {
    self.onTap = onTap
  }

  func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .center, spacing: 0) {
      configuration.label
      Spacer()
      Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.systemLight)
        .rotationEffect(.degrees(configuration.isExpanded ? 90 : 0))
    }
    .padding(.horizontal(16))
    .frame(maxWidth: .infinity)
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
        .frame(maxWidth: .infinity)
        .disclosureGroupStyle(self)

    }
  }
}
