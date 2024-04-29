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
      return Fail(error: APIError.invalidRequestError("Invalid path")).eraseToAnyPublisher()
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
      return Fail(error: error).eraseToAnyPublisher()
    }
  }

  func driverStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "seasonDriverStandings_", ofType: "json") else {
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

  func constructorStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "seasonConstructorStandings_", ofType: "json") else {
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

  func currentSeasonSchedule(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<RaceTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "currentSeasonSchedule", ofType: "json") else {
      return Fail(error: APIError.invalidRequestError("Invalid path")).eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<RaceTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Fail(error: error).eraseToAnyPublisher()
    }
  }

  func qualifyingResults(round: String, year: String) -> AnyPublisher<MRData<RaceTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "qualifyingResults", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<RaceTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Fail(error: error).eraseToAnyPublisher()
    }
  }

  func raceResults(round: String, year: String) -> AnyPublisher<MRData<RaceTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "raceResults", ofType: "json") else {
      return Fail(error: APIError.invalidRequestError("Invalid path")).eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<RaceTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Fail(error: error).eraseToAnyPublisher()
    }
  }

  func currentSeasonDriverStandings() -> AnyPublisher<MRData<StandingsTable>, any Error> {
    return self.driverStandingsForSeason(season: "current")
  }

  func currentSeasonConstructorStandings() -> AnyPublisher<MRData<StandingsTable>, any Error> {
    return self.constructorStandingsForSeason(season: "current")
  }



}
