//
//  Extensions.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 30/03/2024.
//

import Foundation
import Combine

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

enum FetchStatus {
  case ongoing, finished, ready
}

extension Publisher {
  func observeFetchStatus<S: Subject>(with fetchStatusSubject: S) -> Publishers.HandleEvents<Self> where S.Output == FetchStatus, S.Failure == Never {
    return handleEvents(receiveSubscription: { _ in
      // When fetching:
      fetchStatusSubject.send(.ongoing)
    }, receiveCompletion: { completion in
      switch completion {
      case .finished:
        // When finish successfully:
        fetchStatusSubject.send(.finished)
      case .failure:
        // When finish with error:
        fetchStatusSubject.send(.ready)
      }
    }, receiveCancel: {
      // When being cancelled:
      fetchStatusSubject.send(.ready)
    })
  }
}
