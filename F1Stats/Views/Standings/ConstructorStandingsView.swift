//
//  ConstructorStandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import SwiftUI
import Combine

struct ConstructorStandingsView: View {

  @ObservedObject var viewModel: ConstructorStandingsViewModel

    
  var body: some View {
    ScrollView {
      if viewModel.fetchStatus == .ongoing {
        HStack {
          Spacer()
          ProgressView()
            .modifier(LargeProgressView(tint: .F1Stats.appWhite))
            .padding(.all(32))
          Spacer()
        }
      }

      if let standings = viewModel.constructorStandings {
        VStack {
          Text("Constructor Standings")
            .typography(type: .heading(color: .F1Stats.primary))
            .padding(.all(16))

          VStack {
            HStack {
              Spacer()
              Text("Points")
                .typography(type: .body(color: .F1Stats.appDark))
            }
            ForEach(Array(standings.enumerated()), id: \.offset) { (index, result) in
              raceStandingsRow(result: result)
                .modifier(ConstructorCardDisplayer(constructor: result.constructor))
              if index < standings.count - 1 {
                Divider().padding(.all(0))
              }
            }
          }
          .padding(.all(8))
          .padding(.trailing)
        }
        .padding(.bottom(16))
        .padding(.leading(8))
        .padding(.top(8))
        .cardStyling()
        .padding(.all(16))
      }
    }
    .onAppear(perform: viewModel.fetchConstructorStandings)
  }

  func raceStandingsRow(result: ConstructorStanding) -> some View {
    HStack(alignment: .center) {
      Text(result.positionText)
        .frame(width: 30)
        .typography(type: .body(color: .F1Stats.appDark))
      VStack(alignment:.leading) {
        Text(result.constructor.name)
          .typography(type: .subHeader(color: .F1Stats.appDark))
          .clickableUnderline()

        Text(result.constructor.nationality)
          .typography(type: .body(color: .F1Stats.appDark))
      }
      Spacer()
      Text(result.points)
        .typography(type: .body(color: .F1Stats.appDark))
    }
  }

}

#Preview {
    ConstructorStandingsView(viewModel: ConstructorStandingsViewModel(apiSeasons: APISeasonsStub()))
}
