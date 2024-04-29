//
//  SeasonRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import Foundation
import SwiftUI
import Combine

class SeasonCardViewModel: ObservableObject {

  @Published internal var wikipediaViewModel: WikipediaViewModel
  @Published internal var seasonConstructorStandingsViewModel: SeasonConstructorStandingsViewModel
  @Published internal var seasonDriverStandingsViewModel: SeasonDriverStandingsViewModel

  private var subscriptions = Set<AnyCancellable>()

  private let season: SeasonModel
  private let apiSeason: APISeasonsProtocol

  init(season: SeasonModel, wikipediaApi: WikipediaAPIProtocol, apiSeason: APISeasonsProtocol) {
    self.season = season
    self.apiSeason = apiSeason
    self.wikipediaViewModel = WikipediaViewModel(url: season.url, wikipediaApi: wikipediaApi)
    self.seasonConstructorStandingsViewModel = SeasonConstructorStandingsViewModel(seasonId: season.id, apiSeasons: apiSeason)
    self.seasonDriverStandingsViewModel = SeasonDriverStandingsViewModel(seasonId: season.id, apiSeasons: apiSeason)

    seasonDriverStandingsViewModel
      .objectWillChange
      .sink(receiveValue: viewModelChanged)
      .store(in: &subscriptions)

    seasonConstructorStandingsViewModel
      .objectWillChange
      .sink(receiveValue: viewModelChanged)
      .store(in: &subscriptions)

    wikipediaViewModel
      .objectWillChange
      .sink(receiveValue: viewModelChanged)
      .store(in: &subscriptions)
  }

  private func viewModelChanged(output: ObservableObjectPublisher.Output) {
    self.objectWillChange.send()
  }
}
