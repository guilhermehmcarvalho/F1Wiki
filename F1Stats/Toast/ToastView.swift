//
//  ToastView.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 19/04/2024.
//

import SwiftUI

struct ToastView: View {

  var style: ToastStyle
  var message: String
  var width = CGFloat.infinity
  var onCancelTapped: (() -> Void)
  var onTapped: (() -> Void)?

  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      Image(systemName: style.iconFileName)
        .foregroundColor(.F1Stats.primary)
      Text(message)
        .typography(type: .subHeader())

      Spacer(minLength: 10)

      Button {
        onCancelTapped()
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(.F1Stats.primary)
      }
    }
    .onTapGesture(perform: {
      onTapped?()
    })
    .padding()
    .frame(minWidth: 0, maxWidth: width)
    .background(Color.F1Stats.appWhite)
    .cornerRadius(8)
    .padding(.horizontal, 16)
  }
}

#Preview {
  ToastView(style: .error, message: "This is a toast") {}
}
