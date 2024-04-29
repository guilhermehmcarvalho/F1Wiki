//
//  APIError.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 19/04/2024.
//

import Foundation

enum APIError: LocalizedError {
  /// Invalid request, e.g. invalid URL
  case invalidRequestError(String)

  /// Indicates an error on the transport layer, e.g. not being able to connect to the server
  case transportError(Error)

  /// Received an invalid response, e.g. non-HTTP result
  case invalidResponse

  /// Server-side validation error
  case validationError(String)

  /// The server sent data in an unexpected format
  case decodingError(Error)

  case timeoutError

  var errorDescription: String? {
    switch self {
    case .invalidRequestError(let message):
      return "Red Flag! \n\(message)"
    case .transportError(let error):
      return "Red Flag! \n\(error)"
    case .invalidResponse:
      return "Red Flag! \nInvalid response\nTry updating the app."
    case .validationError(let reason):
      return "Red Flag! \n\(reason)"
    case .decodingError:
      return "Red Flag! \nUnexpected response\nTry updating the app."
    case .timeoutError:
      return "Red Flag!\nRequest took too long.\nPlease try again later"
    }
  }
}
