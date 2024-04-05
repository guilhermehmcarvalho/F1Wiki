//
//  APIConstructorsStub.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation
import Combine

class APIConstructorsStub: APIConstructorsProtocol {
  let delay: Double

  init(delay: Double = 0) {
    self.delay = delay
  }

  func listOfAllConstructors(limit: Int, offset: Int) -> AnyPublisher<MRData<ConstructorTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "constructorList", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
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
      return Empty().eraseToAnyPublisher()
    }
  }

  func listOfConstructorStandings(constructorId: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "constructorStandings", ofType: "json") else {
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
