//
//  MRData.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 30/03/2024.
//

import Foundation

/// The base node for all API responses
/// It always contains a table as the main element
/// Since this table  will vary it's type and name
/// we use a generics for it's type and get the name for decoding based on this type as well
struct MRData<T: Decodable>: Decodable {
  let table: T
  let series: String
  let url: String
  let limit: Int
  let offset: Int
  let total: Int

  struct CodingKeys: CodingKey {

    var stringValue: String

    init?(stringValue: String) {
      self.stringValue = stringValue
    }

    var intValue: Int?

    init?(intValue: Int) {
     return nil
    }

    static var table: Self { Self(stringValue: "\(T.self)")! }
    static var series: Self { Self(stringValue: "series")! }
    static var url: Self { Self(stringValue: "url")! }
    static var limit: Self { Self(stringValue: "limit")! }
    static var offset: Self { Self(stringValue: "offset")! }
    static var total: Self { Self(stringValue: "total")! }
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.table = try container.decode(T.self, forKey: .table)
    self.series = try container.decode(String.self, forKey: .series)
    self.url = try container.decode(String.self, forKey: .url)
    self.limit = try container.decode(Int.self, forKey: .limit)
    self.offset = try container.decode(Int.self, forKey: .offset)
    self.total = try container.decode(Int.self, forKey: .total)
  }
}
