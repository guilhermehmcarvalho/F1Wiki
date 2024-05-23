//
//  LocalDriversAPI.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 23/05/2024.
//

import Foundation
import Combine
import SwiftData

class LocalDriversAPI: APIDriversProtocol {
	final var baseURL: String
	final var urlSession: URLSession
	var modelContext: ModelContext

	init(baseURL: String, urlSession: URLSession, modelContext: ModelContext) {
		self.baseURL = baseURL
		self.urlSession = urlSession
		self.modelContext = modelContext
	}

	func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<[Driver], Error> {
		do {
			let descriptor = FetchDescriptor<Driver>(sortBy: [SortDescriptor(\.familyName)])
			let drivers = try modelContext.fetch(descriptor)
			return Just(drivers)
				.setFailureType(to: Error.self)
				.eraseToAnyPublisher()
		} catch {
			return Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
		}
	}

	func listOfDriverStandings(driverId: String) -> AnyPublisher<MRData<StandingsTable>, Error> {
		guard let url = URL(string: baseURL.appending("drivers/\(driverId)/driverStandings.json")) else {
			return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
		}

		return urlSession.dataTaskPublisher(for: url)
				.tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
				.eraseToAnyPublisher()
	}
}
