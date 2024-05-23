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
          .tint(.F1Stats.primary)
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
          .tint(.F1Stats.primary)
      }
    }
    .toastView(toast: $viewModel.errorToast)
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
        CardStyling.makeCardTitle(summary.title)
          .padding(.vertical(16))
      }
      
      if viewModel.standingLists != nil {
        stats
          .padding(.horizontal(12))
          .padding(.bottom)
      } else if viewModel.fetchStandingsStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.primary)
          .padding(32)
      }
    }
    .cardStyling()
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
            Text("Teams:")
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
}

#Preview {
  DriverCardView(viewModel: DriverCardViewModel(driver: Driver.stub,
                                                wikipediaApi: WikipediaAPIStub(delay: 0),
                                                driverApi: APIDriversStub(delay: 1)))
}
