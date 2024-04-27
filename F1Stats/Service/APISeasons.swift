//
//  APISeasons.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation
import Combine

protocol APISeasonsProtocol {
  func listOfAllSeasons(limit: Int, offset: Int) -> AnyPublisher<MRData<SeasonTable>, Error>
  func driverStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, Error>
  func constructorStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, Error>
  func currentSeasonSchedule(limit: Int, offset: Int) -> AnyPublisher<MRData<RaceTable>, Error>
  func qualifyingResults(round: String, year: String) -> AnyPublisher<MRData<RaceTable>, any Error>
  func raceResults(round: String, year: String) -> AnyPublisher<MRData<RaceTable>, any Error>
  func currentSeasonDriverStandings() -> AnyPublisher<MRData<StandingsTable>, Error>
  func currentSeasonConstructorStandings() -> AnyPublisher<MRData<StandingsTable>, Error>
}

class APISeasons: APISeasonsProtocol {
  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllSeasons(limit: Int, offset: Int) -> AnyPublisher<MRData<SeasonTable>, any Error> {
      var components = URLComponents(string: baseURL.appending("seasons.json"))
      components?.queryItems = [
        URLQueryItem(name: "limit", value: "\(limit)"),
        URLQueryItem(name: "offset", value: "\(offset)")
      ]

      guard let url = components?.url else {
        return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
      }

      return urlSession.dataTaskPublisher(for: url)
          .tryDecodeResponse(type: MRData<SeasonTable>.self, decoder: JSONDecoder())
          .mapError({ error in
            print(error)
            return error
          })
          .eraseToAnyPublisher()
  }

  func driverStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    let components = URLComponents(string: baseURL.appending("\(season)/driverStandings.json"))

    guard let url = components?.url else {
      return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
        .mapError({ error in
          print(error)
          return error
        })
        .eraseToAnyPublisher()
  }


  func constructorStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    let components = URLComponents(string: baseURL.appending("\(season)/constructorStandings.json"))

    guard let url = components?.url else {
      return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
        .mapError({ error in
          print(error)
          return error
        })
        .eraseToAnyPublisher()
  }

  func currentSeasonSchedule(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<RaceTable>, any Error> {
    var components = URLComponents(string: baseURL.appending("current.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<RaceTable>.self, decoder: JSONDecoder())
        .mapError({ error in
          print(error)
          return error
        })
        .eraseToAnyPublisher()
  }

  func qualifyingResults(round: String, year: String) -> AnyPublisher<MRData<RaceTable>, any Error> {
    let components = URLComponents(string: baseURL.appending("\(year)/\(round)/qualifying.json"))

    guard let url = components?.url else {
      return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<RaceTable>.self, decoder: JSONDecoder())
        .mapError({ error in
          print(error)
          return error
        })
        .eraseToAnyPublisher()
  }

  func raceResults(round: String, year: String) -> AnyPublisher<MRData<RaceTable>, any Error> {
    let components = URLComponents(string: baseURL.appending("\(year)/\(round)/results.json"))

    guard let url = components?.url else {
      return Fail(error: APIError.invalidRequestError("Invalid URL")).eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<RaceTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func currentSeasonDriverStandings() -> AnyPublisher<MRData<StandingsTable>, any Error> {
    return driverStandingsForSeason(season: "current")
  }

  func currentSeasonConstructorStandings() -> AnyPublisher<MRData<StandingsTable>, any Error> {
    return constructorStandingsForSeason(season: "current")
  }

}
