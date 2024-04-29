//
//  URLSessionManager.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 26/04/2024.
//

import Foundation

class URLSessionManager {

  static let urlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 8
    configuration.timeoutIntervalForResource = 8
    return URLSession(configuration: configuration)
  }()
}
