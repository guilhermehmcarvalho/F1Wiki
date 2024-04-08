//
//  ConstructorStanding.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation

struct ConstructorStanding: Decodable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let constructor: ConstructorModel

  enum CodingKeys: String, CodingKey {
    case constructor = "Constructor"
    case wins
    case points
    case positionText
    case position
  }

}
