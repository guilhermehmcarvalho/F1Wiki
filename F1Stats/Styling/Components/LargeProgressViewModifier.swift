//
//  LargeProgressViewModifier.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import SwiftUI

struct LargeProgressView: ViewModifier {
  let tint: Color

  init(tint: Color = .F1Stats.systemLight) {
    self.tint = tint
  }

    func body(content: Content) -> some View {
      content.tint(tint)
        .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
    }
}
