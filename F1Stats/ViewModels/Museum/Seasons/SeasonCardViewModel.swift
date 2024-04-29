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

  @ObservedObject internal var wikipediaViewModel: WikipediaViewModel
  @ObservedObject internal var seasonConstructorStandingsViewModel: SeasonConstructorStandingsViewModel
  @ObservedObject internal var seasonDriverStandingsViewModel: SeasonDriverStandingsViewModel

  private let season: SeasonModel
  private let apiSeason: APISeasonsProtocol

  init(season: SeasonModel, wikipediaApi: WikipediaAPIProtocol, apiSeason: APISeasonsProtocol) {
    self.season = season
    self.apiSeason = apiSeason
    self.wikipediaViewModel = WikipediaViewModel(url: season.url, wikipediaApi: wikipediaApi)
    self.seasonConstructorStandingsViewModel = SeasonConstructorStandingsViewModel(seasonId: season.id, apiSeasons: apiSeason)
    self.seasonDriverStandingsViewModel = SeasonDriverStandingsViewModel(seasonId: season.id, apiSeasons: apiSeason)
  }
}
