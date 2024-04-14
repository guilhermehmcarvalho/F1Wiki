//
//  DriverStandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import SwiftUI

struct DriverStandingsView: View {
  @ObservedObject var viewModel: DriverStandingsViewModel

  init(viewModel: DriverStandingsViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    VStack {
      if viewModel.fetchStatus == .ongoing {
        HStack {
          Spacer()
          ProgressView()
            .modifier(LargeProgressView(tint: .F1Stats.primary))
            .padding(.all(32))
          Spacer()
        }
      }

      VStack {
        Text("Driver Standings")
          .typography(type: .heading(color: .F1Stats.primary))
      }.padding(.all(8))

      if let standings = viewModel.driverStandings {
        ForEach(Array(standings.enumerated()), id: \.offset) { (index, result) in
          raceStandingsRow(result: result)
          if index < standings.count - 1 {
            Divider().padding(.all(0))
          }
        }
      }
    }
    .frame(minHeight: 600)
    .padding(.all(8))
    .modifier(CardView(fill: .F1Stats.systemYellow))
    .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 8))
    .onAppear(perform: viewModel.fetchDriverStandings)
  }

  func raceStandingsRow(result: DriverStanding) -> some View {
    HStack(alignment: .center) {
      Text(result.positionText)
        .frame(width: 20)
        .typography(type: .small(color: .F1Stats.systemDark))
      Text(result.driver.fullName)
        .typography(type: .body(color: .F1Stats.systemDark))
      Spacer()
        Text(result.constructorsAppended)
        .typography(type: .body(color: .F1Stats.systemDark))
    }
  }

}

#Preview {
  DriverStandingsView(viewModel: DriverStandingsViewModel(apiSeasons: APISeasonsStub()))
}
