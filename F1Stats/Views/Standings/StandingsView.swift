//
//  StandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import SwiftUI
import Combine

struct StandingsView: View {
  
  @ObservedObject var viewModel: StandingsViewModel
  
  var body: some View {
    ZStack {
      
      Color.F1Stats.appDark.ignoresSafeArea()
      
      VStack {
        tabButtons
          .safeAreaPadding(.top)
          .padding(.horizontal(8))
        
        TabView(selection: $viewModel.selectedTab) {
          DriverStandingsView(viewModel: viewModel.driverStandingsViewModel)
            .tag(0)

          ConstructorStandingsView(viewModel: viewModel.constructorStandingsViewModel)
            .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
      }
    }
  }
  
  var tabButtons: some View {
    HStack(alignment: .center, spacing: 0) {
      ForEach(Array(viewModel.tabItems.enumerated()), id: \.offset) { index, item in
        ZStack {
          Color(Color.F1Stats.appWhite.opacity(0.5))
            .cornerRadius(5)
          
          Text(item)
            .typography(type: .body(color: .F1Stats.appWhite))
            .padding(.all(4))
        }
        .opacity(viewModel.selectedTab == index ? 1 : 0.5)
        .frame(minWidth: 0, maxWidth: .infinity)
        .onTapGesture { viewModel.selectedTab = index }
        .tag(index)
        .padding(2)
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity)
    .frame(height: 35)
  }
}

#Preview {
    StandingsView(viewModel: StandingsViewModel(apiSeasons: APISeasonsStub(),
                                               apiDrivers: APIDriversStub(),
                                               wikipediaAPI: WikipediaAPIStub()))
}
