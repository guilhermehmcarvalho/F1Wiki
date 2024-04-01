//
//  Driver.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import XMLCoder

struct DriverTable: Decodable {
  let drivers: [Driver]
  let driverId: String?
  let url: String?

  enum CodingKeys: String, CodingKey {
    case drivers = "Driver"
    case driverId = "driverId"
    case url = "url"
  }
}

struct Driver: Decodable {
  let driverId: String
  let url: String
  let DateOfBirth: String
  let GivenName: String
  let FamilyName: String
  let Nationality: String
}

extension Driver: Identifiable {
    var id: String { return driverId }
}
