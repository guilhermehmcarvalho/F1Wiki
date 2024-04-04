//
//  APIDrivers.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine

protocol APIDriversProtocol {
  func listOfAllDrivers(limit: Int, offset: Int) -> AnyPublisher<MRData<DriverTable>, Error>
}

class APIDrivers: APIDriversProtocol {

  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<DriverTable>, Error> {
    var components = URLComponents(string: baseURL.appending("drivers.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func listOfDriverStandings(driverId: String, limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<DriverTable>, Error> {
    var components = URLComponents(string: baseURL.appending("/drivers/\(driverId)/driverStandings.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }
}

class APIDriversStub: APIDriversProtocol {
  func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<DriverTable>, any Error> {
    let drivers = DriverModel.stubs(times: limit)
    let driverTable = DriverTable(drivers: drivers,
                                  driverId: nil,
                                  url: nil)

    return Just(MRData(table: driverTable,
                       limit: limit,
                       offset: offset,
                       total: limit,
                       series: "F1",
                       url: ""))
    .delay(for: .seconds(1), scheduler: RunLoop.main)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

extension DriverModel {
  static let stub = DriverModel(driverId: "Senna",
                              url: "http://en.wikipedia.org/wiki/Ayrton_Senna",
                              dateOfBirth: "1960-03-21",
                               givenName: "Ayrton",
                              familyName: "Senna",
                              nationality: "Brazilian")

  static func stubs(times: Int) -> [DriverModel] {
    return [] + repeatElement(DriverModel.stub, count: times)
  }
}
