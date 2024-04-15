//
//  RaceResultsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import SwiftUI

struct RaceResultsView: View {
  
  @ObservedObject var viewModel: RaceResultsViewModel

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

      if let raceModel = viewModel.raceModel {
        VStack {
          Text("\(raceModel.raceName)")
            .typography(type: .subHeader(color: .F1Stats.primary))
          Text("Race Result")
            .typography(type: .heading(color: .F1Stats.primary))
        }.padding(.all(8))

        if let raceResults = raceModel.raceResults {
          ForEach(Array(raceResults.enumerated()), id: \.element.driver) { (index, result) in
            raceStandingsRow(result: result)
              .modifier(DriverCardDisplayer(driver: result.driver))
            if index < raceResults.count - 1 {
              Divider().padding(.all(0))
            }
          }
        }
      }
    }
    .frame(minHeight: 600)
    .padding(.all(8))
    .modifier(CardView(fill: .F1Stats.appWhite))
    .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 8))
    .onAppear(perform: viewModel.fetchRaceResults)
  }

  func raceStandingsRow(result: RaceResult) -> some View {
    HStack(alignment: .center) {
      Text(result.positionText)
        .frame(width: 20)
        .typography(type: .small(color: .F1Stats.appDark))
      HStack {
        if (result.positionsShifted > 0) {
          Text( "+\(result.positionsShifted)")
            .typography(type: .small(color: .F1Stats.appGreen))
        } else if (result.positionsShifted == 0) {
          Text( "\(result.positionsShifted)")
            .typography(type: .small(color: .F1Stats.appDark))
        } else {
          Text("\(result.positionsShifted)")
            .typography(type: .small(color: .F1Stats.primary))
        }
      }
      .frame(width: 30)
      
      Text(result.driver.fullName)
        .typography(type: .body(color: .F1Stats.appDark))
      Spacer()
      Text(result.constructor.name)
        .typography(type: .body(color: .F1Stats.appDark))
    }
  }
}

#Preview {
  RaceResultsView(viewModel: RaceResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "1"))
}
