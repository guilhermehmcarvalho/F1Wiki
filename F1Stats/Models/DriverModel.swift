//
//  Driver.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation

struct DriverTable: Decodable {
  let drivers: [DriverModel]
  let driverId: String?
  let url: String?

  enum CodingKeys: String, CodingKey {
    case drivers = "Drivers"
    case driverId = "driverId"
    case url = "url"
  }
}

struct DriverModel: Decodable, Hashable {
  let driverId: String
  let url: String
  let dateOfBirth: String
  let givenName: String
  let familyName: String
  let nationality: String
}

extension DriverModel: Identifiable {
    var id: String { return driverId }
}

extension DriverModel {
  var fullName: String {
    "\(givenName) \(familyName)"
  }

	var birthdateFormatted: String? {
		let formatterIn = DateFormatter()
		print(dateOfBirth)
		formatterIn.dateFormat = "yyyy-MM-dd"
		guard let bday = formatterIn.date(from: dateOfBirth) else { return nil }

		let formatterOut = DateFormatter()
		formatterOut.dateStyle = .short
		return formatterOut.string(from: bday)
	}
}
