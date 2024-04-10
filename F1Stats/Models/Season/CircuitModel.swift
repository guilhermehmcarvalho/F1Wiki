//
//  CircuitModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation

struct CircuitModel: Decodable {
    let circuitID: String
    let url: String
    let circuitName: String
    let location: LocationModel

    enum CodingKeys: String, CodingKey {
        case circuitID = "circuitId"
        case url = "url"
        case circuitName = "circuitName"
        case location = "Location"
    }
}
