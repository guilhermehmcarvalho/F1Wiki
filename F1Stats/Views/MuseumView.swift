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
      
      Color.F1Stats.systemDark.ignoresSafeArea()
      
      VStack {
        tabButtons
          .safeAreaPadding()
        
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
    HStack {
      Text("Seasons")
        .typography(type: .heading(color: viewModel.selectedTab == 0 ? .accentColor : .white))
        .onTapGesture { viewModel.selectedTab = 0 }
      Spacer()
      Text("Drivers")
        .typography(type: .heading(color: viewModel.selectedTab == 1 ? .accentColor : .white))
        .onTapGesture { viewModel.selectedTab = 1 }
      Spacer()
      Text("Constructors")
        .onTapGesture { viewModel.selectedTab = 2 }
        .typography(type: .heading(color: viewModel.selectedTab == 2 ? .accentColor : .white))
    }
  }
}

#Preview {
    MuseumView(viewModel: MuseumViewModel( apiSeasons: APISeasonsStub(),
               wikipediaAPI: WikipediaAPIStub(),
               driverAPI: APIDriversStub(),
               constructorsAPI: APIConstructorsStub()))
}
