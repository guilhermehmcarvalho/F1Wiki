//
//  Status.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import Foundation

enum Status: String, Decodable {
  case accident = "Accident"
  case collision = "Collision"
  case finished = "Finished"
  case disqualified = "Disqualified"
  case gearbox = "Gearbox"
  case engine = "Engine"
  case transmission = "Transmission"
  case clutch = "Clutch"
  case hydraulics = "Hydraulics"
  case electrical = "Electrical"
  case plus1Lap = "+1 Lap"
  case plus2Laps = "+2 Laps"
  case plus3Laps = "+3 Laps"
  case plus4Laps = "+4 Laps"
  case plus5Laps = "+5 Laps"
  case plus6Laps = "+6 Laps"
  case plus7Laps = "+7 Laps"
  case plus8Laps = "+8 Laps"
  case plus9Laps = "+9 Laps"
  case spunOff = "Spun off"
  case radiator = "Radiator"
  case suspension = "Suspension"
  case brakes = "Brakes"
  case differential = "Differential"
  case overheating = "Overheating"
  case mechanical = "Mechanical"
  case tyre = "Tyre"
  case driverSeat = "Driver Seat"
  case puncture = "Puncture"
  case driveshaft = "Driveshaft"
  case Retired = "Retired"
  case other
}

extension Status {
    public init(from decoder: Decoder) throws {
        self = try Status(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .other
    }
}
