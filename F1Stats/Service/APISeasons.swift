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
  
}
