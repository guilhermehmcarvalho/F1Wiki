//
//  ConstructorRowView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import SwiftUI

struct ConstructorRowView: View {
  
  let constructor: ConstructorModel

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
          Text(constructor.name)
            .textCase(.uppercase)
            .typography(type: .heading(color: .F1Stats.primary))
        }
        Text(constructor.nationality)
          .typography(type: .small(color: .F1Stats.appDark))
      }
      Spacer()
      Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.appDark)
    }
    .listRowBackground(
      Color.F1Stats.appWhite
    )
  }
}
