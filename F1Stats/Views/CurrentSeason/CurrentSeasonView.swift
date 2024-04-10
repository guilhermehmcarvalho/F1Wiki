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
  @State private var selectedIndex: Int = 0

  init(viewModel: CurrentSeasonViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    if viewModel.fetchStatus == .ongoing {
      ProgressView()
        .modifier(LargeProgressView())
        .padding(.all(32))
    }
    GeometryReader { geo in
      TabView(selection: $selectedIndex) {
        ForEach (viewModel.raceViewModels.enumerated().sorted { $0.element.round < $1.element.round}, id: \.element) { index, raceViewModel in
            RaceView(viewModel: raceViewModel)
              .frame(width: geo.size.width - geo.safeAreaInsets.trailing)
              .padding(.trailing, geo.safeAreaInsets.trailing)
              .tag(index)
              .onAppear {
                if index == 0 {
                  raceViewModel.animate(true)
                }
                viewModel.onItemDisplayed(currentItem: raceViewModel)
              }
          }
      }
      .onChange(of: selectedIndex, viewModel.changedTabIndex)
      .tabViewStyle(PageTabViewStyle())
      .onAppear(perform: viewModel.fetchCurrentSchedule)
    }
    .ignoresSafeArea()
  }
}

#Preview {
  CurrentSeasonView(viewModel: CurrentSeasonViewModel(apiSeasons: APISeasonsStub()))
}
