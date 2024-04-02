//
//  DriverRow.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 02/04/2024.
//

import Foundation
import SwiftUI

struct DriverRow : View {
  let color: Color
  let driver: Driver

  init(color: Color = .red, driver: Driver) {
    self.color = color
    self.driver = driver
  }

  var body: some View {
    HStack(alignment: .center) {
      VStack(alignment: .leading) {
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
      Image(systemName: "chevron.down")
    }
  }
}
