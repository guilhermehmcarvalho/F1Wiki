//
//  DriverCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import SwiftUI
import Combine

struct DriverCardView: View {
  @ObservedObject var viewModel: DriverCardViewModel

  init(viewModel: DriverCardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    VStack {
      if viewModel.fetchSummaryStatus == .ongoing || viewModel.isLoadingImage {
        ProgressView()
          .tint(.F1Stats.appWhite)
      } else if let summary = viewModel.summaryModel {
        mainCardView(summary: summary)
          .padding(.all(16))
          .scalingTransition()

        DriverBioCard(bio: summary.extract)
          .padding(.all(16))
          .scalingTransition()
      }

      if let standingLists = viewModel.standingLists, standingLists.isEmpty == false {
        DriverStandingsCard(standingLists: standingLists)
          .padding(16)
          .scalingTransition()
      } else if viewModel.fetchStandingsStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.appWhite)
      }
    }
    .safeAreaPadding(.top)
    .onAppear(perform: viewModel.fetchSummary)
    .onAppear(perform: viewModel.fetchStandings)
  }

  func mainCardView(summary: WikipediaSummaryModel) -> some View {
    VStack {
      ZStack(alignment: .bottom) {
        if let image = viewModel.image {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .padding(.top)
            .frame(maxHeight: 400)
            .clipped()
        } else if viewModel.isLoadingImage {
          ProgressView()
            .tint(.F1Stats.primary)
        }
        title(summary.title)
          .padding(.vertical(16))
      }
      if viewModel.standingLists != nil {
        stats
          .padding(.horizontal(16))
          .padding(.bottom)
      } else if viewModel.fetchStandingsStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.primary)
          .padding(32)
      }
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
          if viewModel.careerPoints != nil {
            Text("Career points:")
          }
          if viewModel.seasons != nil {
            Text("Seasons:")
          }
          if viewModel.constructors != nil {
            Text("Constructors:")
          }
        }
        .typography(type: .body(color: Color.F1Stats.appDark))

        VStack(alignment: .leading) {
          Text(viewModel.driver.nationality)
          if let championships = viewModel.championships, championships > 0 {
            Text("\(championships)")
          }
          if let wins = viewModel.wins {
            Text("\(wins)")
          }
          if let points = viewModel.careerPoints {
            Text("\(points)")
          }
          if let seasons = viewModel.seasons {
            Text("\(seasons)")
          }
          if let constructors = viewModel.constructors {
            Text(constructors)
              .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.leading)
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
  DriverCardView(viewModel: DriverCardViewModel(driver: DriverModel.stub,
                                            wikipediaApi: WikipediaAPIStub(delay: 1),
                                            driverApi: APIDriversStub(delay: 1)))
}
