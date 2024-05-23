//
//  Driver.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation

struct DriverTable: Decodable {
  let drivers: [Driver]
  let driverId: String?
  let url: String?

  enum CodingKeys: String, CodingKey {
    case drivers = "Drivers"
    case driverId = "driverId"
    case url = "url"
  }
}
