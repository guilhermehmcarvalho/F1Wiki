//
//  RaceModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation

// MARK: - RaceTable
struct RaceTable: Decodable {
    let season: String
    let races: [RaceModel]

    enum CodingKeys: String, CodingKey {
        case season = "season"
        case races = "Races"
    }
}

struct RaceModel: Decodable {
    let season: String
    let round: String
    let url: String
    let raceName: String
    let circuit: CircuitModel
    let date: String
    let time: String
    let firstPractice: EventModule
    let secondPractice: EventModule
    let thirdPractice: EventModule?
    let qualifying: EventModule
    let sprint: EventModule?

    enum CodingKeys: String, CodingKey {
        case season = "season"
        case round = "round"
        case url = "url"
        case raceName = "raceName"
        case circuit = "Circuit"
        case date = "date"
        case time = "time"
        case firstPractice = "FirstPractice"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
        case qualifying = "Qualifying"
        case sprint = "Sprint"
    }
}

extension RaceModel: Identifiable {
  var id: String {
    date
  }
}
