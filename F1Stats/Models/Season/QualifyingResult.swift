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
    let q1: String
    let q2: String?
    let q3: String?

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
