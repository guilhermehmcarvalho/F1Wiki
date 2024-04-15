//
//  ConstructorModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation

struct ConstructorTable: Decodable {
    let constructors: [ConstructorModel]

    enum CodingKeys: String, CodingKey {
        case constructors = "Constructors"
    }
}

struct ConstructorModel: Decodable, Hashable {
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

extension ConstructorModel: Identifiable {
    var id: String { return constructorID }
}

extension ConstructorModel {
  static let stub = ConstructorModel(constructorID: "Ferrari",
                              url: "https://en.wikipedia.org/wiki/Scuderia_Ferrari",
                              name: "Ferrari",
                              nationality: "Italian")
}
