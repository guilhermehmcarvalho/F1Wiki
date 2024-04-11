//
//  Status.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import Foundation

enum Status: String, Decodable {
  case accident = "Accident"
  case Collision = "Collision"
  case finished = "Finished"
  case disqualified = "Disqualified"
  case gearbox = "Gearbox"
  case Engine = "Engine"
  case Transmission = "Transmission"
  case Clutch = "Clutch"
  case Hydraulics = "Hydraulics"
  case Electrical = "Electrical"
  case plus1Lap = "+1 Lap"
  case plus2Laps = "+2 Laps"
  case plus3Laps = "+3 Laps"
  case plus4Laps = "+4 Laps"
  case plus5Laps = "+5 Laps"
  case plus6Laps = "+6 Laps"
  case plus7Laps = "+7 Laps"
  case plus8Laps = "+8 Laps"
  case plus9Laps = "+9 Laps"
  case SpunOff = "Spun off"
  case Radiator = "Radiator"
  case Suspension = "Suspension"
  case Brakes = "Brakes"
  case Differential = "Differential"
  case Overheating = "Overheating"
  case Mechanical = "Mechanical"
  case Tyre = "Tyre"
  case DriverSeat = "Driver Seat"
  case Puncture = "Puncture"
  case Driveshaft = "Driveshaft"
}
