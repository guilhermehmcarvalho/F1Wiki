//
//  WikipediaViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI
import Combine

class WikipediaViewModel: ObservableObject {

  private let wikipediaApi: WikipediaAPIProtocol
  @Published var summaryModel: WikipediaSummaryModel?
  @Published var mediaList: WikiCommonsMedia?
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  @Published var fetchStatus: FetchStatus = .ready
  final let url: String
  private var cancellable: AnyCancellable?

  init(url: String, wikipediaApi: WikipediaAPIProtocol) {
    self.url = url
    self.wikipediaApi = wikipediaApi
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  internal func fetchSummary() -> Void {
    guard summaryModel == nil else { return }
    cancellable = wikipediaApi.getSummaryFor(url: url)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.summaryModel = response
      }
  }

  internal func fetchMediaList() -> Void {
    guard mediaList == nil else { return }
    cancellable = wikipediaApi.getMediaList(forUrl: url)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.mediaList = response
      }
  }
}
