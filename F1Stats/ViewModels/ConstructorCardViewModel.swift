//
//  ConstructorCardViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import Foundation
import Combine
import SwiftUI

class ConstructorCardViewModel: ObservableObject {

  private let wikipediaApi: WikipediaAPIProtocol
  private var apiConstructor: APIConstructorsProtocol
  internal let constructor: ConstructorModel

  @Published var summaryModel: WikipediaSummaryModel?
  @Published var fetchStandingsStatus: FetchStatus = .ready
  @Published var fetchSummaryStatus: FetchStatus = .ready
  @Published var fetchImageStatus: FetchStatus = .ready
  @Published var standingLists: [StandingsList]?
  @Published var wins: Int?
  @Published var championships: Int?
  @Published var seasons: Int?
  @Published var image: UIImage? {
    didSet {
      if image != nil {
        isLoadingImage = false
      }
    }
  }
  @Published var isLoadingImage = false
  @Published var errorToast: Toast?

  private var loader: ImageLoader?
  private var mediaItems: [MediaItem]?

  private(set) var fetchSummaryStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private(set) var fetchStandingsStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private(set) var toastSubject = PassthroughSubject<Toast?, Never>()

  private var subscriptions = Set<AnyCancellable>()

  init(constructor: ConstructorModel,
       wikipediaApi: WikipediaAPIProtocol,
       apiConstructor: APIConstructorsProtocol) {
    self.wikipediaApi = wikipediaApi
    self.apiConstructor = apiConstructor
    self.constructor = constructor

    fetchStandingsStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStandingsStatus)

    fetchSummaryStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchSummaryStatus)

    toastSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorToast)
  }

  internal func fetchMedia() -> Void {
    guard mediaItems == nil else { return }
    isLoadingImage = true
    wikipediaApi.getMediaList(forUrl: constructor.url)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] response in
        self?.mediaItems = response.items
        if let imageString = self?.mediaItems?.first?.srcset.last?.link,
            let imageUrl = URL(string: imageString) {
          self?.loadImage(imageUrl: imageUrl)
        } else {
          self?.isLoadingImage = false
        }
      }
      .store(in: &subscriptions)
  }

  private func loadImage(imageUrl: URL) {
    self.isLoadingImage = true
    self.loader = ImageLoader(url: imageUrl)
    self.loader?.load()
    self.loader?.$image.sink(receiveCompletion: { [weak self] _ in
      self?.isLoadingImage = false
    }, receiveValue: { image in
      self.image = image
      self.objectWillChange.send()
    })
    .store(in: &subscriptions)
  }

  internal func fetchSummary() -> Void {
    guard summaryModel == nil else { return }
    wikipediaApi.getSummaryFor(url: constructor.url)
      .assignToastForError(with: toastSubject)
      .observeFetchStatus(with: fetchSummaryStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] response in
        self?.summaryModel = response
        if let imageString = response.originalimage?.source, let imageUrl = URL(string: imageString) {
          self?.loadImage(imageUrl: imageUrl)
        } else {
          // if there is no thumbnail for any reason (happens with svgs eventually) fetch more media
          self?.fetchMedia()
        }
      }
      .store(in: &subscriptions)
  }

  internal func fetchStandings() {
    apiConstructor.listOfConstructorStandings(constructorId: constructor.constructorID)
      .assignToastForError(with: toastSubject)
      .observeFetchStatus(with: fetchStandingsStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in }  receiveValue: { [weak self] response in
        self?.loadData(standingsList: response.table.standingsLists)
      }
      .store(in: &subscriptions)
  }

  private func loadData(standingsList: [StandingsList]) {
    self.standingLists = standingsList

    seasons = 0
    wins = 0
    championships = 0

    for standing in standingsList {
      seasons? += 1

      for season in standing.constructorStanding ?? [] {
        wins? += Int(season.wins) ?? 0
        if Int(season.position) == 1 {
          championships? += 1
        }
      }
    }
  }

}
