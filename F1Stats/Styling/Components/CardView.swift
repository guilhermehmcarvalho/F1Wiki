//
//  CardView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 09/04/2024.
//

import Foundation
import SwiftUI

struct CardView: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background {
        RoundedRectangle(cornerRadius: 8)
          .fill(.white)
          .shadow(radius: 8, y: 10)
      }
  }
}
