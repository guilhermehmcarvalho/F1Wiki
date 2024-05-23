//
//  Driver.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 22/05/2024.
//

import Foundation
import SwiftData

@Model
class Driver: Codable {
	let id: Int
	let driverId: String
	let number: Int?
	let code: String?
	let givenName: String
	let familyName: String
	let dateOfBirth: String
	let nationality: String
	let url: String

	enum CodingKeys: String, CodingKey {
		case id = "Id"
		case driverId = "driverId"
		case number = "number"
		case code = "code"
		case givenName = "givenName"
		case familyName = "familyName"
		case dateOfBirth = "dateOfBirth"
		case nationality = "nationality"
		case url = "url"
	}

	init(id: Int,
		 driverId: String,
		 number: Int?,
		 code: String?,
		 givenName: String,
		 familyName: String,
		 dateOfBirth: String,
		 nationality: String,
		 url: String) {
		self.id = id
		self.driverId = driverId
		self.number = number
		self.code = code
		self.givenName = givenName
		self.familyName = familyName
		self.dateOfBirth = dateOfBirth
		self.nationality = nationality
		self.url = url
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.driverId = try container.decode(String.self, forKey: .driverId)
		self.number = try? container.decodeIfPresent(Int.self, forKey: .number)
		self.givenName = try container.decode(String.self, forKey: .givenName)
		self.familyName = try container.decode(String.self, forKey: .familyName)
		self.dateOfBirth = try container.decode(String.self, forKey: .dateOfBirth)
		self.nationality = try container.decode(String.self, forKey: .nationality)
		self.url = try container.decode(String.self, forKey: .url)

		self.code = try {
			let code = try container.decodeIfPresent(String.self, forKey: .code)
			if code != "\n" {
				return code
			}

			return nil
		}()
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.driverId, forKey: .driverId)
		try container.encode(self.number, forKey: .number)
		try container.encode(self.code, forKey: .code)
		try container.encode(self.givenName, forKey: .givenName)
		try container.encode(self.familyName, forKey: .familyName)
		try container.encode(self.dateOfBirth, forKey: .dateOfBirth)
		try container.encode(self.nationality, forKey: .nationality)
		try container.encode(self.url, forKey: .url)
		try container.encode(self.id, forKey: .id)
	}
}


//extension Driver: Identifiable {
//	var id: String { return id ?? driverId }
//}

extension Driver {
  var fullName: String {
	"\(givenName) \(familyName)"
  }
}


#if DEBUG
extension Driver {
	static let stub = Driver(id: 1, driverId: "senna", number: nil,
							 code: nil, givenName: "Ayrton", familyName: "Senna",
							 dateOfBirth: "1960-03-21", nationality: "Brazilian",
							 url: "http://en.wikipedia.org/wiki/Ayrton_Senna")
}
#endif
