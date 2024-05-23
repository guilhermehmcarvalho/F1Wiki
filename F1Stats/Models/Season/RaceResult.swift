//
//  RaceResult.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 10/04/2024.
//

import Foundation

struct RaceResult: Decodable {
    let number: String
    let position: String
    let positionText: String
    let points: String
    let driver: Driver
    let constructor: ConstructorModel
    let grid: String
    let laps: String
    let status: Status?
    let time: ResultTime?
    let fastestLap: FastestLap?

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case position = "position"
        case positionText = "positionText"
        case points = "points"
        case driver = "Driver"
        case constructor = "Constructor"
        case grid = "grid"
        case laps = "laps"
        case status = "status"
        case time = "Time"
        case fastestLap = "FastestLap"
    }

  struct FastestLap: Decodable {
      let rank: String
      let lap: String
      let time: FastestLapTime
      let averageSpeed: AverageSpeed

      enum CodingKeys: String, CodingKey {
          case rank = "rank"
          case lap = "lap"
          case time = "Time"
          case averageSpeed = "AverageSpeed"
      }
  }

  struct AverageSpeed: Decodable {
      let units: Units
      let speed: String

      enum CodingKeys: String, CodingKey {
          case units = "units"
          case speed = "speed"
      }
  }

  enum Units: String, Decodable {
      case kph = "kph"
  }

  struct FastestLapTime: Decodable {
      let time: String

      enum CodingKeys: String, CodingKey {
          case time = "time"
      }
  }

  struct ResultTime: Decodable {
      let millis: String
      let time: String

      enum CodingKeys: String, CodingKey {
          case millis = "millis"
          case time = "time"
      }
  }
}

extension RaceResult {
  var positionsShifted: Int {
    Int(grid)! - Int(position)!
  }
}
