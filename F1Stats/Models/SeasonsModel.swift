//
//  SeasonsModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation

struct SeasonTable: Codable {
    let seasons: [SeasonModel]

    enum CodingKeys: String, CodingKey {
        case seasons = "Seasons"
    }
}

struct SeasonModel: Codable {
    let season: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case season = "season"
        case url = "url"
    }
}

extension SeasonModel: Identifiable {
  var id: String { season }
}

extension SeasonModel {
  static let stub = SeasonModel(season: "1989", url: "https://en.wikipedia.org/wiki/2021_Formula_One_World_Championship")
}
