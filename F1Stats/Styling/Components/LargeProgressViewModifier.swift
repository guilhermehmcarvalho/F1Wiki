//
//  LargeProgressViewModifier.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import SwiftUI

struct LargeProgressView: ViewModifier {
    func body(content: Content) -> some View {
      content.tint(.F1Stats.systemLight)
        .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
    }
}
