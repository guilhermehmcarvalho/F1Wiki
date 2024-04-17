//
//  SeasonCardDisplayer.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI


// At the moment dependency injection in this view is not being enforced in this view
// as it would generate basically too much boilerplate, since this view can be called from
// almost the whole app
struct SeasonCardDisplayer: ViewModifier {
  let season: SeasonModel
  let wikipediaApi: WikipediaAPIProtocol
  let seasonAPI: APISeasonsProtocol

  init(season: SeasonModel,
       seasonAPI: APISeasonsProtocol = APISeasons(baseURL: Config.baseURL),
       wikipediaApi: WikipediaAPIProtocol = WikipediaAPI(baseURL: Config.wikipediaURL)) {
    self.season = season
    self.seasonAPI = seasonAPI
    self.wikipediaApi = wikipediaApi
  }

  @State var seasonCardViewModel: SeasonCardViewModel?

  func body(content: Content) -> some View {
    content
      .contentShape(Rectangle())
      .onTapGesture {
        seasonCardViewModel = SeasonCardViewModel(season: season,
                                                  wikipediaApi: wikipediaApi,
                                                  apiSeason: seasonAPI)
      }
      .fullScreenCover(isPresented: Binding<Bool>.constant(seasonCardViewModel != nil)) {
        CustomSheet(content: {
          if let seasonCardViewModel = seasonCardViewModel {
            SeasonCardView(viewModel: seasonCardViewModel)
          }
        }, dismiss: {
          seasonCardViewModel = nil
        })
      }
  }
}

#Preview {
  Text("tap me")
    .modifier(SeasonCardDisplayer(season: SeasonModel(season: "2021", url: "https://en.wikipedia.org/wiki/2021_Formula_One_World_Championship")))
}

