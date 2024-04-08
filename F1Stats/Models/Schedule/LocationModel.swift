//
//  LocationModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation

struct LocationModel: Decodable {
    let lat: String
    let long: String
    let locality: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case long = "long"
        case locality = "locality"
        case country = "country"
    }
}
