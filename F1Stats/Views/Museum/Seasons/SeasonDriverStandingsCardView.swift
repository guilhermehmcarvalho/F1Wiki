//
//  SeasonDriverStandingsCardView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 17/04/2024.
//

import SwiftUI
import Combine

struct SeasonDriverStandingsCardView: View {
  @ObservedObject var viewModel: SeasonDriverStandingsViewModel

  var body: some View {
    VStack {
      if viewModel.fetchStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.primary)
      } else {
        card
      }
    }
    .onAppear(perform: viewModel.fetchStandings)
  }

  var card: some View {
    VStack {
      CardStyling.makeCardTitle("Driver Standings")
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))

      VStack(alignment: .leading) {
        HStack(alignment: .center) {
          Text("Pos")
            .typography(type: .body(color: .F1Stats.appDark))
            .frame(width: 30)
          Text("Driver/Team")
            .typography(type: .body(color: .F1Stats.appDark))
          Spacer()
          Text("Wins")
            .typography(type: .body(color: .F1Stats.appDark))
            .frame(width: 50)
          Text("Points")
            .typography(type: .body(color: .F1Stats.appDark))
            .frame(width: 50)
        }
        .frame(height: 15)
        .padding(.horizontal(8))

        ForEach(viewModel.standingLists?.first?.driverStandings ?? [], id: \.driver) { standing in
          HStack {
            Text(standing.position)
              .typography(type: .body())
              .frame(width: 30)

            VStack(alignment: .leading) {
              Text(standing.driver.fullName)
                .typography(type: .heavyBody())
                .clickableUnderline()
                .modifier(DriverCardDisplayer(driver: standing.driver))

              Text(standing.constructorsAppended)
                .typography(type: .body())
            }

            Spacer()

            Text(standing.wins)
              .typography(type: .body())
              .frame(width: 50)

            Text(standing.points)
              .typography(type: .body())
              .frame(width: 50)

          }
          .padding(.horizontal(8))
          .padding(.vertical(2))
        }
      }
      .padding(16)
    }.cardStyling()
  }
}

#Preview {
  SeasonCardView(viewModel: SeasonCardViewModel(season: SeasonModel.stub,
                                                wikipediaApi: WikipediaAPIStub(),
                                                apiSeason: APISeasonsStub(delay: 1)))
}
