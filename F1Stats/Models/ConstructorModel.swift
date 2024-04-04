//
//  ConstructorModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation

struct ConstructorModel: Decodable {
    let constructorID: String
    let url: String
    let name: String
    let nationality: String

  enum CodingKeys: String, CodingKey {
    case constructorID = "constructorId"
    case url = "url"
    case name = "name"
    case nationality = "nationality"
  }
}
