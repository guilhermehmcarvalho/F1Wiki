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

  var body: some View {
    ZStack {
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
