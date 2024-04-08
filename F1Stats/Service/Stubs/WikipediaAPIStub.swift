//
//  WikipediaAPIStub.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 04/04/2024.
//

import Foundation
import Combine

class WikipediaAPIStub: WikipediaAPIProtocol {

  let delay: Double

  init(delay: Double = 0) {
    self.delay = delay
  }

  func getSummaryFor(url: String) -> AnyPublisher<WikipediaSummaryModel, any Error> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    guard let path = Bundle.main.path(forResource: "wikipediaSummary", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try decoder.decode(WikipediaSummaryModel.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Empty().eraseToAnyPublisher()
    }
  }

  func getMediaList(forUrl url: String) -> AnyPublisher<WikiCommonsMedia, any Error> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    guard let path = Bundle.main.path(forResource: "wikiMediaList", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try decoder.decode(WikiCommonsMedia.self, from: jsonData)
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
