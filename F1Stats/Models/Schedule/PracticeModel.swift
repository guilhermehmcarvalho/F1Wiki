//
//  EventModule.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation

struct EventModule: Decodable {
    let date: String
    let time: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case time = "time"
    }
}
