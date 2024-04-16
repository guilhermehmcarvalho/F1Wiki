//
//  DriverRowView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import SwiftUI

struct DriverRowView: View {

  let driver: DriverModel

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
          Text(driver.familyName)
            .textCase(.uppercase)
            .typography(type: .heading(color: .F1Stats.primary))
          Text(driver.givenName)
            .typography(type: .small(color: .F1Stats.appDark))
        }
        Text(driver.nationality)
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
