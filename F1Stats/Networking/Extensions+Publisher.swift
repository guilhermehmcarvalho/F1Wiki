//
//  Extensions.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 30/03/2024.
//

import Foundation
import Combine

extension Publisher {
//  func tryDecodeResponse<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Publishers.TryMap<Self, Data>, Item, Coder>
  func tryDecodeResponse<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.TryMap<Self, Item>
    where Item: Decodable, Coder: JSONDecoder, Self.Output == (data: Data, response: URLResponse) {
    return self
      .tryMap { output -> Data in

        guard let urlResponse = output.response as? HTTPURLResponse else {
          throw APIError.invalidResponse
        }

        switch urlResponse.statusCode {
        case 200..<300: return output.data
        case 400: throw APIError.invalidResponse
        case 408: throw APIError.timeoutError
        default: throw APIError.invalidResponse
        }
      }
      .tryMap { data -> Item in
        do {
          return try decoder.decode(type.self, from: data)
        }
        catch {
          debugPrint(error.localizedDescription)
          throw APIError.decodingError(error)
        }
      }
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

extension Publisher {
  func observeFetchStatus<S: Subject>(with booleanSubject: S) -> Publishers.HandleEvents<Self> where S.Output == Bool, S.Failure == Never {
    return handleEvents(receiveSubscription: { _ in
      // When fetching:
      booleanSubject.send(true)
    }, receiveCompletion: { _ in
      // When finish successfully or with error:
      booleanSubject.send(false)
    }, receiveCancel: {
      // When being cancelled:
      booleanSubject.send(false)
    })
  }
}
