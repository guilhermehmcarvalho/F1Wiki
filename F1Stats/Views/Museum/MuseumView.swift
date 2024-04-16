//
//  MuseumView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 13/04/2024.
//

import SwiftUI

struct MuseumView: View {
  
  @ObservedObject var viewModel: MuseumViewModel
  
  var body: some View {
    ZStack {
    
      Color.F1Stats.appDark.ignoresSafeArea()
      
      VStack {
        tabButtons
          .safeAreaPadding(.top)
          .padding(.horizontal(8))

        TabView(selection: $viewModel.selectedTab) {
          SeasonsView(viewModel: viewModel.seasonsViewModel)
            .tag(0)
          DriversView(viewModel: viewModel.driversViewModel)
            .tag(1)
          ConstructorsView(viewModel: viewModel.constructorsViewModel)
            .tag(2)
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
    MuseumView(viewModel: MuseumViewModel( apiSeasons: APISeasonsStub(),
               wikipediaAPI: WikipediaAPIStub(),
               driverAPI: APIDriversStub(),
               constructorsAPI: APIConstructorsStub()))
}
