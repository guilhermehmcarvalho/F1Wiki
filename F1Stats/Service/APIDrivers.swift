//
//  APIDrivers.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine
import XMLCoder

protocol APIDriversProtocol {
  func listOfAllDrivers() -> AnyPublisher<MRData<DriverTable>, Error>
}

class APIDrivers: APIDriversProtocol {

  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllDrivers() -> AnyPublisher<MRData<DriverTable>, Error> {
    guard let url = URL(string: baseURL.appending("drivers")) else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: XMLDecoder())
        .eraseToAnyPublisher()
  }
}

class MockAPIDrivers: APIDriversProtocol {
  func listOfAllDrivers() -> AnyPublisher<MRData<DriverTable>, any Error> {
    let table = DriverTable(Driver: [
      Driver(driverId: "Senna", url: "http://en.wikipedia.org/wiki/Ayrton_Senna", DateOfBirth: "1960-03-21",
             GivenName: "Ayrton", FamilyName: "Senna", Nationality: "Brazilian"),
      Driver(driverId: "MSC", url: "http://en.wikipedia.org/wiki/Michael_Schumacher", DateOfBirth: "1969-01-03",
             GivenName: "Michael", FamilyName: "Schumacher", Nationality: "German"),
    ])

    return Just(MRData(table: table))
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
  

}
