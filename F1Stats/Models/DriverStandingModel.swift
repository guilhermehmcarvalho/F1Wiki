//
//  DriverStandingModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation

struct StandingsTable: Decodable {
    let driverId: String
    let standingsLists: [StandingsList]

  enum CodingKeys: String, CodingKey {
    case driverId
    case standingsLists = "StandingsLists"
  }
}

struct StandingsList: Decodable {
    let season: String
    let round: String
    let driverStandings: [DriverStanding]

  enum CodingKeys: String, CodingKey {
    case round
    case season
    case driverStandings = "DriverStandings"
  }
}

struct DriverStanding: Decodable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let driver: DriverModel
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
