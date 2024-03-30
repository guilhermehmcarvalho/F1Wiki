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

  init(baseURL: String) {
    self.baseURL = baseURL
  }

  func listOfAllDrivers() throws -> AnyPublisher<MRData<DriverTable>, Error> {

    guard let url = URL(string: baseURL.appending("drivers")) else {
      throw URLError(.badURL)
    }

    return URLSession.shared.dataTaskPublisher(for: url)
        .tryDecodeResponse(type: MRData<DriverTable>.self, decoder: XMLDecoder())
        .eraseToAnyPublisher()
  }
}

extension Publisher {
  func tryDecodeResponse<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Publishers.TryMap<Self, Data>, Item, Coder> where Item: Decodable, Coder: TopLevelDecoder, Self.Output == (data: Data, response: URLResponse) {
    return self
      .tryMap { output in
        guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return output.data
      }
      .decode(type: type, decoder: decoder)
  }
}
