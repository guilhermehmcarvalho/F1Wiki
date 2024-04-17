//
//  SeasonRowView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import SwiftUI

struct SeasonRowView: View {
  let season: SeasonModel

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .firstTextBaseline, spacing: 4) {
        Text(season.season)
          .textCase(.uppercase)
          .typography(type: .heading())
        Spacer()
        Image(systemName: "chevron.right")
          .foregroundColor(.F1Stats.appDark)
      }
    }
    .listRowBackground(
      Color.F1Stats.appWhite
    )
  }
}


#Preview {
  SeasonsView(viewModel: SeasonsViewModel(apiSeasons: APISeasonsStub(),
                                                                 wikipediaAPI: WikipediaAPIStub()))
}

