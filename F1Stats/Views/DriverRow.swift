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

  var header: some View {
    HStack(alignment: .center, spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
          Text(driver.familyName)
            .textCase(.uppercase)
            .typography(type: .heading())
          Text(driver.givenName)
            .typography(type: .small())
          Spacer()
        }
        Text(driver.nationality)
          .typography(type: .small())
      }
      Image(systemName: "chevron.right")
        .foregroundColor(.F1Stats.systemLight)
    }
    .padding(.horizontal(16))
    .padding(.vertical(8))
    .background(background)
  }

  var body: some View {
    VStack(spacing: 0) {
      header
    }
    .listRowInsets(.all(0))
    .listRowBackground(
      RoundedRectangle(cornerRadius: 5)
        .foregroundColor(.clear)
        .background(Color.clear)
    )
  }

  var background: some View {
    RoundedRectangle(cornerRadius: 5)
      .foregroundColor(Color.F1Stats.systemDarkSecondary)
  }
}

#Preview {
  DriversView(driversViewModel: DriversViewModel(driverApi: MockAPIDrivers()))
}
