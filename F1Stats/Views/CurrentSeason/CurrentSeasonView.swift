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

  var sortedRaces: [EnumeratedSequence<[RaceViewModel]>.Element] {
    viewModel.raceViewModels.enumerated().sorted { $0.element.round < $1.element.round}
  }

  var body: some View {
    ZStack {
      Color.F1Stats.appDark.ignoresSafeArea()

      if viewModel.fetchStatus == .ongoing {
        ProgressView()
          .modifier(LargeProgressView())
          .padding(.all(32))
      }

      GeometryReader { geo in
        TabView(selection: $viewModel.selectedIndex) {
          ForEach (sortedRaces, id: \.element) { index, raceViewModel in
            RaceView(viewModel: raceViewModel)
              .frame(width: geo.size.width - geo.safeAreaInsets.trailing)
              .padding(.trailing, geo.safeAreaInsets.trailing)
              .tag(index)
              .onAppear {
                viewModel.onItemDisplayed(currentItem: raceViewModel)
              }
              .onDisappear {
                raceViewModel.animate(false)
              }
          }
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear(perform: viewModel.fetchCurrentSchedule)
      }
      .ignoresSafeArea(edges: .top)
      .toastView(toast: $viewModel.errorToast)
    }
  }
}

#Preview {
  CurrentSeasonView(viewModel: CurrentSeasonViewModel(apiSeasons: APISeasonsStub()))
}
