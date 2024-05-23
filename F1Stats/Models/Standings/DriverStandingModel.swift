//
//  DriverStandingModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation

struct DriverStanding: Decodable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let driver: Driver
    let constructors: [ConstructorModel]

  enum CodingKeys: String, CodingKey {
    case driver = "Driver"
    case constructors = "Constructors"
    case wins
    case points
    case positionText
    case position
  }
}

extension DriverStanding {
  var constructorsAppended: String {
    self.constructors.map { $0.name }.joined(separator: ", ")
  }
}
