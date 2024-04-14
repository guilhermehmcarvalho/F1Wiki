//
//  APIConstructors.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine

protocol APIConstructorsProtocol {
  func listOfAllConstructors(limit: Int, offset: Int) -> AnyPublisher<MRData<ConstructorTable>, Error>
  func listOfConstructorStandings(constructorId: String) -> AnyPublisher<MRData<StandingsTable>, Error>
}

class APIConstructors: APIConstructorsProtocol {
  
  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllConstructors(limit: Int, offset: Int) -> AnyPublisher<MRData<ConstructorTable>, any Error> {
    var components = URLComponents(string: baseURL.appending("constructors.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<ConstructorTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

  func listOfConstructorStandings(constructorId: String) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    return listOfConstructorStandings(constructorId: constructorId, limit: 100, offset: 0)
  }

  func listOfConstructorStandings(constructorId: String, limit: Int, offset: Int) -> AnyPublisher<MRData<StandingsTable>, any Error> {
    var components = URLComponents(string: baseURL.appending("constructors/\(constructorId)/constructorStandings.json"))
    components?.queryItems = [
      URLQueryItem(name: "limit", value: "\(limit)"),
      URLQueryItem(name: "offset", value: "\(offset)")
    ]

    guard let url = components?.url else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<StandingsTable>.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
  }

}
