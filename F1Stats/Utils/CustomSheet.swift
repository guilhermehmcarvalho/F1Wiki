//
//  CustomSheet.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import Foundation
import SwiftUI

struct CustomSheet<Content: View>: View {
  @ViewBuilder var content: () -> Content
  @State var position: CGPoint = .zero
  let dismiss: (() -> Void)?
  let topMargin: CGFloat = 64
  let backgroundOpacity: CGFloat = 0.5

  var opacity: CGFloat {
    backgroundOpacity-(-1.0 * position.y/100)/3
  }

  var body: some View {
    ZStack {
      LinearGradient(colors: [.clear, .black.opacity(0.5), .black.opacity(0.8)],
                     startPoint: UnitPoint(x: 0, y: 0),
                     endPoint: UnitPoint(x: 0, y: 0.2))
        .opacity(opacity)
        .ignoresSafeArea()

      OffsetObservingScrollView(offset: $position) {
        Rectangle()
          .opacity(0)
          .contentShape(Rectangle())
          .frame(height: topMargin)
          .onTapGesture {
            dismiss?()
          }
        content()
      }
      .onPreferenceChange(PreferenceKey.self) { position in
        self.position = position
      }
      .onChange(of: position) { oldValue, newValue in
        if newValue.y < -100 {
          dismiss?()
        }
      }
    }
  }
}
