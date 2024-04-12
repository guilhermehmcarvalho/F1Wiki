//
//  QualifyingResultsModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 10/04/2024.
//

import Foundation

struct QualifyingResult: Decodable {
    let number: String
    let position: String
    let driver: DriverModel
    let constructor: ConstructorModel
    let q1: LapTime
    let q2: LapTime?
    let q3: LapTime?

    enum CodingKeys: String, CodingKey {
        case number = "number"
        case position = "position"
        case driver = "Driver"
        case constructor = "Constructor"
        case q1 = "Q1"
        case q2 = "Q2"
        case q3 = "Q3"
    }
}

typealias LapTime = String

extension LapTime {

  var inMiliseconds: Int {
    let minutesString = self.components(separatedBy: ":").first ?? ""
    let secondsString = self.components(separatedBy: ":").last?.components(separatedBy: ".").first ?? ""
    let milisecondsString = self.components(separatedBy: ":").last?.components(separatedBy: ".").last ?? ""

    guard let minutes = Int(minutesString),
          let seconds = Int(secondsString),
    let miliseconds = Int(milisecondsString) else { return 0 }
    return miliseconds + seconds * 1000 + minutes * 60000
  }
}
