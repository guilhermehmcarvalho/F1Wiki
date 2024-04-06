//
//  APISeasonsStub.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import Foundation
import Combine

class APISeasonsStub: APISeasonsProtocol {

  let delay: Double

  init(delay: Double = 0) {
    self.delay = delay
  }

  func listOfAllSeasons(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<SeasonTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "seasonList", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<SeasonTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Empty().eraseToAnyPublisher()
    }
  }

  func driverStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "seasonDriverStandings", ofType: "json") else {
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

  func constructorStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "seasonConstructorStandings", ofType: "json") else {
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
