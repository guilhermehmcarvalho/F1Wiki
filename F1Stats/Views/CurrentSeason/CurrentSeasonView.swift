//
//  CurrentSeasonView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import SwiftUI
import Combine

struct CurrentSeasonView: View {
  @ObservedObject var viewModel: CurrentSeasonViewModel

  init(viewModel: CurrentSeasonViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    GeometryReader { geo in
      ScrollView(.horizontal, showsIndicators: false) {
        
        LazyHStack(spacing: 0) {
          ForEach(viewModel.raceList, id: \.id) { race in
            RaceView(viewModel: RaceViewModel(raceModel: race))
              .frame(width: geo.size.width - geo.safeAreaInsets.trailing)
              .padding(.trailing, geo.safeAreaInsets.trailing)
          }
        }

      }
      .scrollTargetBehavior(.paging)
      .scrollTargetLayout(isEnabled: true)
      .onAppear(perform: viewModel.fetchCurrentSchedule)
    }
    .ignoresSafeArea()
  }
}

#Preview {
  CurrentSeasonView(viewModel: CurrentSeasonViewModel(apiSeasons: APISeasonsStub(),
                                                      wikipediaAPI: WikipediaAPIStub()))
}
