//
//  ConstructorCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import SwiftUI

struct ConstructorCardView: View {
  @ObservedObject var viewModel: ConstructorCardViewModel

  init(viewModel: ConstructorCardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ScrollView {
      VStack {
        if viewModel.fetchStatus == .ongoing {
          ProgressView()
            .tint(.F1Stats.appWhite)
        }
        
        if let summaryModel = viewModel.summaryModel {
          mainCardView(summary: summaryModel)
            .padding(16)
        }
        
        if let standingLists = viewModel.standingLists {
          ConstructorStandingsCard(standingLists: standingLists)
            .padding(16)
        }
      }
      .safeAreaPadding(.top)
      .onAppear(perform: viewModel.fetchSummary)
      .onAppear(perform: viewModel.fetchStandings)
    }
  }

  func mainCardView(summary: WikipediaSummaryModel) -> some View {
    VStack {
      if let image = viewModel.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .padding(.top)
          .padding(.horizontal(16))
          .frame(maxHeight: 250)
          .clipped()
      }

      title(summary.title)

      Text(summary.extract)
        .padding(16)
        .typography(type: .body(color: .F1Stats.appDark))
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)

      stats
        .padding(.horizontal(8))


      Text("*Since 1958")
        .typography(type: .small(color: .F1Stats.appDark))
        .padding(.bottom)
    }
    .background(Color.F1Stats.appWhite)
    .overlay(
      RoundedRectangle(cornerRadius: 16)
        .stroke(Color.F1Stats.appWhite, lineWidth: 16)
    )
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.F1Stats.primary, lineWidth: 4)
        .padding(8)
    )
    .overlay(
      Color.F1Stats.appYellow.opacity(0.1)
    )
  }

  var stats: some View {
    HStack(alignment: .firstTextBaseline, spacing: 8) {
        VStack(alignment: .trailing) {
          Text("Nationality:")
          if let championships = viewModel.championships, championships > 0 {
            Text("Championship wins:")
          }
          if viewModel.wins != nil {
            Text("Race wins:")
          }
          if viewModel.seasons != nil {
            Text("Seasons:")
          }
        }
        .typography(type: .body(color: Color.F1Stats.appDark))

        VStack(alignment: .leading) {
          Text(viewModel.constructor.nationality)
          if let championships = viewModel.championships, championships > 0 {
            Text("\(championships)")
          }
          if let wins = viewModel.wins {
            Text("\(wins)*")
          }
          if let seasons = viewModel.seasons {
            Text("\(seasons)*")
          }
        }
        .typography(type: .body(color: Color.F1Stats.appDark))
      }
  }

  func title(_ title: String) -> some View {
    ZStack {
      Color.F1Stats.primary

      Text(title)
        .textCase(.uppercase)
        .typography(type: .heading(color: .F1Stats.appWhite))
        .padding(.all(4))
        .multilineTextAlignment(.center)
    }
    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
  }
}

#Preview {
  ConstructorCardView(viewModel: ConstructorCardViewModel(constructor: ConstructorModel.stub,
                                                          wikipediaApi: WikipediaAPI(baseURL: Config.wikipediaURL),
                                                          apiConstructor: APIConstructorsStub()))
}
