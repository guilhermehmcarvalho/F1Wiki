//
//  WikipediaAPI.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import Combine

protocol WikipediaAPIProtocol {
  func getSummaryFor(url: String) -> AnyPublisher<WikipediaSummaryModel, Error>
}

class WikipediaAPI: WikipediaAPIProtocol {

  final var baseURL: String
  final var urlSession: URLSession

  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }

  init(baseURL: String, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  func getSummaryFor(url: String) -> AnyPublisher<WikipediaSummaryModel, Error> {
    guard let title = URL(string: url)?.lastPathComponent else {
      return Empty().eraseToAnyPublisher()
    }
    guard let url = URL(string: baseURL.appending("page/summary/\(title)")) else {
      return Empty().eraseToAnyPublisher()
    }

    return urlSession.dataTaskPublisher(for: url)
      .tryDecodeResponse(type: WikipediaSummaryModel.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}
