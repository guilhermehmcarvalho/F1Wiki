//
//  Transitions.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI

extension View {
  func scalingTransition(scaling: CGFloat = 0.9) -> some View {
    return self
      .scrollTransition { content, phase in
        content
          .scaleEffect(phase.isIdentity ? 1.0 : scaling)
      }
  }

  func twistingTransition(startingAngle: Double = Double.random(in: -10..<10), finalAngle: Double = -4, scaling: CGFloat = 0.5) -> some View {
    return self
      .scrollTransition { content, phase in
        content
          .scaleEffect(phase.isIdentity ? 1.0 : scaling)
          .rotationEffect(phase.isIdentity ? Angle(degrees: finalAngle) : Angle(degrees: startingAngle))
      }
  }
}
