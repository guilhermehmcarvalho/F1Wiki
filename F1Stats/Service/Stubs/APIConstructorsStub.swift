//
//  APIConstructorsStub.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation
import Combine

#if DEBUG
class APIConstructorsStub: APIConstructorsProtocol {
  let delay: Double
  let error: APIError?

  init(delay: Double = 0, error: APIError? = nil) {
    self.delay = delay
    self.error = error
  }

  func listOfAllConstructors(limit: Int, offset: Int) -> AnyPublisher<MRData<ConstructorTable>, any Error> {
    if let error = error {
      return Fail(error: error)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }

    guard let path = Bundle.main.path(forResource: "constructorList", ofType: "json") else {
      return Fail(error: APIError.invalidRequestError("Invalid path")).eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<ConstructorTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Fail(error: error).eraseToAnyPublisher()
    }
  }

  func listOfConstructorStandings(constructorId: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    if let error = error {
      return Fail(error: error)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    guard let path = Bundle.main.path(forResource: "constructorStandings", ofType: "json") else {
      return Fail(error: APIError.invalidRequestError("Invalid path")).eraseToAnyPublisher()
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
      return Fail(error: error).eraseToAnyPublisher()
    }
  }
}
#endif
