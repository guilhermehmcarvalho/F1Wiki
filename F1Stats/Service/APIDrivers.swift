//
//  APIDrivers.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine

protocol APIDriversProtocol {
  func listOfAllDrivers(limit: Int, offset: Int) -> AnyPublisher<[Driver], Error>
  func listOfDriverStandings(driverId: String) -> AnyPublisher<MRData<StandingsTable>, Error>
}

class APIDrivers: APIDriversProtocol {
  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<[Driver], Error> {
    var components = URLComponents(string: baseURL.appending("drivers.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: JSONDecoder())
				.map({ driversTable in
					driversTable.table.drivers
				})
        .eraseToAnyPublisher()
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
