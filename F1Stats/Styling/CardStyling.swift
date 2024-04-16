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
