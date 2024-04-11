//
//  BackgroundClearView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import SwiftUI

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
