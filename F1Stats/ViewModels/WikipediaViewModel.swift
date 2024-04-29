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

  @Published var fetchStatus: FetchStatus = .ready
  @Published var summaryModel: WikipediaSummaryModel?
  @Published var mediaList: WikiCommonsMedia?
  @Published internal var errorToast: Toast?

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private var toastSubject = PassthroughSubject<Toast?, Never>()

  final let url: String
  private var cancellable: AnyCancellable?

  init(url: String, wikipediaApi: WikipediaAPIProtocol) {
    self.url = url
    self.wikipediaApi = wikipediaApi

    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)

    toastSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorToast)

    errorToast = Toast(style: .error, message: "TEST")
  }

  internal func fetchSummary() -> Void {
    guard summaryModel == nil else { return }
    cancellable = wikipediaApi.getSummaryFor(url: url)
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink {  _ in } receiveValue: { [weak self] response in
        self?.summaryModel = response
        self?.objectWillChange.send()
      }
  }

  internal func fetchMediaList() -> Void {
    guard mediaList == nil else { return }
    cancellable = wikipediaApi.getMediaList(forUrl: url)
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] response in
        self?.mediaList = response
      }
  }
}
