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
  func qualifyingResults(round: Int, year: String) -> AnyPublisher<MRData<RaceTable>, any Error>
  func raceResults(round: Int, year: String) -> AnyPublisher<MRData<RaceTable>, any Error>
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
        return Empty().eraseToAnyPublisher()
      }

      return urlSession.dataTaskPublisher(for: url)
          .tryDecodeResponse(type: MRData<SeasonTable>.self, decoder: JSONDecoder())
          .eraseToAnyPublisher()
  }

  func driverStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    let components = URLComponents(string: baseURL.appending("\(season)/driverStandings.json"))

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }


  func constructorStandingsForSeason(season: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    let components = URLComponents(string: baseURL.appending("\(season)/constructorStandings.json"))

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func currentSeasonSchedule(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<RaceTable>, any Error> {
    var components = URLComponents(string: baseURL.appending("current.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<RaceTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func qualifyingResults(round: Int, year: String) -> AnyPublisher<MRData<RaceTable>, any Error> {
    var components = URLComponents(string: baseURL.appending("\(year)/\(round)/qualifying.json"))

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<RaceTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func raceResults(round: Int, year: String) -> AnyPublisher<MRData<RaceTable>, any Error> {
    var components = URLComponents(string: baseURL.appending("\(year)/\(round)/qualifying.json"))

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<RaceTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }
}
