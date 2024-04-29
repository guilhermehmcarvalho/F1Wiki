//
//  SeasonConstructorStandingsCardView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 17/04/2024.
//

import SwiftUI

struct SeasonConstructorStandingsCardView: View {
    @ObservedObject var viewModel: SeasonConstructorStandingsViewModel

  var body: some View {
    VStack {
      if viewModel.fetchStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.primary)
      } else if let standingLists = viewModel.standingLists?.first?.constructorStanding,
                standingLists.isEmpty == false {
        card(standings: standingLists)
      }
    }
    .frame(minHeight: 100)
    .onAppear(perform: viewModel.fetchStandings)
    .toastView(toast: $viewModel.errorToast)
  }

  func card(standings: [ConstructorStanding]) -> some View {
    VStack {
      CardStyling.makeCardTitle("Constructor Standings")
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))

      VStack(alignment: .leading) {
        HStack(alignment: .center) {
          Text("Pos")
            .typography(type: .body(color: .F1Stats.appDark))
            .frame(width: 30)
          Text("Team")
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

        ForEach(standings, id: \.constructor) { standing in
          HStack {
            Text(standing.position)
              .typography(type: .body())
              .frame(width: 30)

            Text(standing.constructor.name)
              .typography(type: .heavyBody())
              .clickableUnderline()
              .modifier(ConstructorCardDisplayer(constructor: standing.constructor))

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
