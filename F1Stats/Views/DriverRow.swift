//
//  DriverRow.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 02/04/2024.
//

import Foundation
import SwiftUI

struct DriverRow : View {
  let driver: Driver

  init(driver: Driver) {
    self.driver = driver
  }

  var body: some View {
    HStack(alignment: .center) {
      VStack(alignment: .leading) {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
          Text(driver.familyName)
            .textCase(.uppercase)
            .typography(type: .heading(color: .F1Stats.primary))
          Text(driver.givenName)
            .typography(type: .small(color: .F1Stats.systemLight))
          Spacer()
        }
        Text(driver.nationality)
          .typography(type: .small(color: .F1Stats.systemLight))
      }
      Image(systemName: "chevron.down")
    }
    .listRowBackground(
      RoundedRectangle(cornerRadius: 5)
        .foregroundColor(Color.F1Stats.systemDarkSecondary)
        .padding(
          EdgeInsets(
            top: 2,
            leading: 0,
            bottom: 2,
            trailing: 0
          )
        )
    )
  }
}

#Preview {
  DriversView(driversViewModel: DriversViewModel(driverApi: MockAPIDrivers()))
}
