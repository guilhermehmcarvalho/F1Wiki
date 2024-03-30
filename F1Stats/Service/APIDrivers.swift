//
//  APIDrivers.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine
import XMLCoder

protocol APIDriversProtocol {
  func listOfAllDrivers() throws -> AnyPublisher<MRData<DriverTable>, Error>
}

class APIDrivers: APIDriversProtocol {

  final var baseURL: String
  final var urlSession: URLSession

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func listOfAllDrivers() throws -> AnyPublisher<MRData<DriverTable>, Error> {

    guard let url = URL(string: baseURL.appending("drivers")) else {
      throw URLError(.badURL)
    }

    return urlSession.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: XMLDecoder())
        .eraseToAnyPublisher()
  }
}
