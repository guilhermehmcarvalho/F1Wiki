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

  enum CodingKeys: String, CodingKey {
      case MRData // The top level "MRData" key
  }

  struct ValueKeys: CodingKey {

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
    // Extract the root value "MRData"
    let root = try decoder.container(keyedBy: CodingKeys.self)

    // Extract the other values
    let values = try root.nestedContainer(keyedBy: ValueKeys.self, forKey: .MRData)
    self.table = try values.decode(T.self, forKey: .table)
    self.series = try values.decode(String.self, forKey: .series)
    self.url = try values.decode(String.self, forKey: .url)

    if let limit = try Int(values.decode(String.self, forKey: .limit)) {
      self.limit = limit
    } else {
      throw DecodingError.dataCorruptedError(forKey: .limit, in: values, debugDescription: "")
    }

    if let offset = try Int(values.decode(String.self, forKey: .offset)) {
      self.offset = offset
    } else {
      throw DecodingError.dataCorruptedError(forKey: .offset, in: values, debugDescription: "")
    }

    if let total = try Int(values.decode(String.self, forKey: .total)) {
      self.total = total
    } else {
      throw DecodingError.dataCorruptedError(forKey: .total, in: values, debugDescription: "")
    }
  }

  init(table: T, limit: Int = 30, offset: Int = 0, total: Int, series: String, url: String) {
    self.table = table
    self.series = series
    self.url = url
    self.limit = 30
    self.offset = 0
    self.total = 30
  }
}
