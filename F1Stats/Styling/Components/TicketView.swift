//
//  TicketView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 09/04/2024.
//

import Foundation
import SwiftUI

struct TicketView: ViewModifier {
  let cornerRadius: CGFloat
  let fill: Color

  init(cornerRadius: CGFloat = 24, fill: Color = .white) {
    self.cornerRadius = cornerRadius
    self.fill = fill
  }

  func body(content: Content) -> some View {
    content
      .background {
        TicketShape(cornerRadius: cornerRadius)
          .fill(fill)
          .shadow(radius: 4, x: -2, y: 4)
      }
  }
}

struct TicketShape: Shape {
  let cornerRadius: CGFloat

  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
    path.addArc(center: CGPoint(x: rect.maxX, y: rect.minY),
                radius: cornerRadius, startAngle: .degrees(180),
                endAngle: .degrees(180/2),     clockwise: true)
    path.addArc(center: CGPoint(x: rect.maxX, y: rect.maxY),
                radius: cornerRadius, startAngle: .degrees(180 * 3/2),
                endAngle: .degrees(180),     clockwise: true)
    path.addArc(center: CGPoint(x: rect.minX, y: rect.maxY),
                radius: cornerRadius, startAngle: .degrees(0),
                endAngle: .degrees(180 * 3 / 2),     clockwise: true)
    path.addArc(center: CGPoint(x: rect.minX, y: rect.minY),
                radius: cornerRadius, startAngle: .degrees(180/2),
                endAngle: .degrees(0),     clockwise: true)

    return path
  }
}
