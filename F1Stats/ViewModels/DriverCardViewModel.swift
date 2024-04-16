//
//  DriverCardViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import Foundation
import Combine
import SwiftUI

class DriverCardViewModel: ObservableObject {

  private let wikipediaApi: WikipediaAPIProtocol
  private var driverApi: APIDriversProtocol
  internal let driver: DriverModel

  @Published var summaryModel: WikipediaSummaryModel?
  @Published var fetchSummaryStatus: FetchStatus = .ready
  @Published var fetchStandingsStatus: FetchStatus = .ready
  @Published var standingLists: [StandingsList]?
  @Published var wins: Int?
  @Published var championships: Int?
  @Published var careerPoints: Int?
  @Published var seasons: Int?
  @Published var constructors: String?
  @Published var image: UIImage?
  @Published var isLoadingImage = false
  private var loader: ImageLoader?

  private(set) var fetchStandingsStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private(set) var fetchSummaryStatusSubject = PassthroughSubject<FetchStatus, Never>()

  private var subscriptions = Set<AnyCancellable>()

  init(driver: DriverModel,
       wikipediaApi: WikipediaAPIProtocol, 
       driverApi: APIDriversProtocol) {
    self.wikipediaApi = wikipediaApi
    self.driverApi = driverApi
    self.driver = driver

    fetchStandingsStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStandingsStatus)

    fetchSummaryStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchSummaryStatus)
  }

  internal func fetchSummary() -> Void {
    guard summaryModel == nil else { return }
    wikipediaApi.getSummaryFor(url: driver.url)
      .observeFetchStatus(with: fetchSummaryStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.summaryModel = response
        if let imageString = response.originalimage?.source, let imageURL = URL(string: imageString) {
          self?.loadImage(imageUrl: imageURL)
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
      self.isLoadingImage = false
    })
    .store(in: &subscriptions)
  }

  internal func fetchStandings() {
    driverApi.listOfDriverStandings(driverId: driver.driverId)
      .observeFetchStatus(with: fetchStandingsStatusSubject)
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
    careerPoints = 0

    var constructorList: [ConstructorModel] = []

    for standing in standingsList {
      seasons? += 1

      for season in standing.driverStandings ?? [] {
        wins? += Int(season.wins) ?? 0
        if Int(season.position) == 1 {
          championships? += 1
        }
        careerPoints? += Int(season.points) ?? 0
        constructorList.append(contentsOf: season.constructors)
      }
    }

    constructorList = Array(Set(constructorList))
    constructors = constructorList.map { $0.name }.joined(separator: ", ")
  }

}
