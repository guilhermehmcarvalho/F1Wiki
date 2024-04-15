//
//  CardView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 09/04/2024.
//

import Foundation
import SwiftUI

extension View {
  func makeCardView(fill: Color = .F1Stats.appWhite) -> some View {
    return self.background {
      RoundedRectangle(cornerRadius: 8)
        .fill(fill)
        .shadow(radius: 8, y: 10)
    }
  }
}
