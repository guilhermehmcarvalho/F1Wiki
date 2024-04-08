//
//  APISchedule.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation
import Combine

protocol APIScheduleProtocol {
  func currentSeasonSchedule(limit: Int, offset: Int) -> AnyPublisher<MRData<RaceTable>, Error>
}

class APISchedule: APIScheduleProtocol {
  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
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

}
