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
