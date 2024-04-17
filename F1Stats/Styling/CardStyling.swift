//
//  CardStyling.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI

extension View {
  func cardStyling() -> some View {
    return self
      .background(Color.F1Stats.appWhite)
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.F1Stats.appWhite, lineWidth: 16)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.F1Stats.primary, lineWidth: 4)
          .padding(8)
      )
      .overlay(
        Color.F1Stats.appYellow.opacity(0.1)
        .allowsHitTesting(false)
      )
  }
}

struct CardStyling {
  static func makeCardTitle(_ title: String) -> some View {
    ZStack {
      Color.F1Stats.primary

      Text(title)
        .textCase(.uppercase)
        .typography(type: .heading(color: .F1Stats.appWhite))
        .padding(.all(4))
        .multilineTextAlignment(.center)
    }
    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
  }
}
