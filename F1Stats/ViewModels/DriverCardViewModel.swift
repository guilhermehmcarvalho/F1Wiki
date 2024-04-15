//
//  DriverCardViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import Foundation
import Combine

class DriverCardViewModel: ObservableObject {

  private let wikipediaApi: WikipediaAPIProtocol
  private var driverApi: APIDriversProtocol
  internal let driver: DriverModel

  @Published var summaryModel: WikipediaSummaryModel?
  @Published var mediaList: WikiCommonsMedia?
  @Published var fetchStatus: FetchStatus = .ready
  @Published var standingLists: [StandingsList]?
  @Published var wins: Int?
  @Published var championships: Int?
  @Published var careerPoints: Int?
  @Published var seasons: Int?
  @Published var constructors: String?

  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()

  private var subscriptions = Set<AnyCancellable>()

  init(driver: DriverModel,
       wikipediaApi: WikipediaAPIProtocol, 
       driverApi: APIDriversProtocol) {
    self.wikipediaApi = wikipediaApi
    self.driverApi = driverApi
    self.driver = driver
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }

  internal func fetchSummary() -> Void {
    guard summaryModel == nil else { return }
    wikipediaApi.getSummaryFor(url: driver.url)
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
    driverApi.listOfDriverStandings(driverId: driver.driverId)
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

//protocol DriverCardDisplayer {
//  var driverCardViewModel: DriverCardViewModel? { get set }
//  func displayDriverCard(_ driver: DriverModel)
//  func dismissDriverCard()
//}
