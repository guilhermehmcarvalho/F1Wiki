//
//  APIDriversStub.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation
import Combine

class APIDriversStub: APIDriversProtocol {
  let delay: Double

  init(delay: Double = 0) {
    self.delay = delay
  }

  func listOfAllDrivers(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<DriverTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "driverList", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<DriverTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Empty().eraseToAnyPublisher()
    }
  }
  
  func listOfDriverStandings(driverId: String) -> AnyPublisher<MRData<StandingsTable>, Error> {
    guard let path = Bundle.main.path(forResource: "driverStandings", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }
    
    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<StandingsTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
      
    } catch let error {
      print(error)
      return Empty().eraseToAnyPublisher()
    }
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
