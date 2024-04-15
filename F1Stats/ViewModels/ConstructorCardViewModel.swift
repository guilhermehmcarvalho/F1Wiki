//
//  ConstructorCardViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import Foundation
import Combine

class ConstructorCardViewModel: ObservableObject {

  private let wikipediaApi: WikipediaAPIProtocol
  private var apiConstructor: APIConstructorsProtocol
  internal let constructor: ConstructorModel

  @Published var summaryModel: WikipediaSummaryModel?
//  @Published var mediaList: WikiCommonsMedia?
  @Published var fetchStatus: FetchStatus = .ready
  @Published var standingLists: [StandingsList]?
  @Published var wins: Int?
  @Published var championships: Int?
  @Published var seasons: Int?

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  private var subscriptions = Set<AnyCancellable>()

  init(constructor: ConstructorModel,
       wikipediaApi: WikipediaAPIProtocol,
       apiConstructor: APIConstructorsProtocol) {
    self.wikipediaApi = wikipediaApi
    self.apiConstructor = apiConstructor
    self.constructor = constructor
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  internal func fetchSummary() -> Void {
    guard summaryModel == nil else { return }
    wikipediaApi.getSummaryFor(url: constructor.url)
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
      .store(in: &subscriptions)
  }

  internal func fetchStandings() {
    apiConstructor.listOfConstructorStandings(constructorId: constructor.constructorID)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      }  receiveValue: { [weak self] response in
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
