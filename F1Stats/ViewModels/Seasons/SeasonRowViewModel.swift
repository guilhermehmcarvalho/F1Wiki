//
//  SeasonRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import Foundation
import SwiftUI
import Combine

class SeasonRowViewModel: ObservableObject {
  internal let season: SeasonModel
  private var apiSeason: APISeasonsProtocol
  @Published internal var wikipediaViewModel: WikipediaViewModel

  init(season: SeasonModel, wikipediaApi: WikipediaAPIProtocol, apiSeason: APISeasonsProtocol) {
    self.season = season
    self.apiSeason = apiSeason
    self.wikipediaViewModel = WikipediaViewModel(url: season.url, wikipediaApi: wikipediaApi)
  }

  internal func onTap(isExpanded: Bool) {
    if isExpanded {
      wikipediaViewModel.fetchSummary()
    }
  }


  internal var seasonConstructorStandingsViewModel: SeasonConstructorStandingsViewModel {
    SeasonConstructorStandingsViewModel(seasonId: season.id, apiSeasons: apiSeason)
  }

  internal var seasonDriverStandingsViewModel: SeasonDriverStandingsViewModel {
    SeasonDriverStandingsViewModel(seasonId: season.id, apiSeasons: apiSeason)
  }
}
