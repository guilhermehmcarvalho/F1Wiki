//
//  StandingsTable.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation

struct StandingsTable: Decodable {
  let driverId: String?
  let constructorId: String?
  let standingsLists: [StandingsList]

  enum CodingKeys: String, CodingKey {
    case driverId
    case constructorId
    case standingsLists = "StandingsLists"
  }
}

struct StandingsList: Decodable {
    let season: String
    let round: String
    let driverStandings: [DriverStanding]?
    let constructorStanding: [ConstructorStanding]?

  enum CodingKeys: String, CodingKey {
    case round
    case season
    case driverStandings = "DriverStandings"
    case constructorStanding = "ConstructorStandings"
  }
}
