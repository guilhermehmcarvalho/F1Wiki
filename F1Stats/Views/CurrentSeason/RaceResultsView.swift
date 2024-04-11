//
//  RaceResultsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import SwiftUI

struct RaceResultsView: View {

  @ObservedObject var viewModel: RaceResultsViewModel

  var sortedResults: [EnumeratedSequence<[RaceResult]>.Element] {
    let results = (viewModel.raceModel?.raceResults ?? []).enumerated()
    return results.sorted { Int($0.element.position)! < Int($1.element.position)! }
  }

  var body: some View {
    ScrollView {
      ZStack {
        VStack {
          if let raceModel = viewModel.raceModel {
            Text("\(raceModel.raceName) Result")
              .typography(type: .heading(color: .F1Stats.primary))
              .padding()

            ForEach(sortedResults, id: \.element.position) { index, result in
              raceStandingsView(result: result)
              if index < sortedResults.count - 1 {
                Divider()
              }
            }
          }
          if viewModel.fetchStatus == .ongoing {
            ProgressView()
              .modifier(LargeProgressView())
              .padding(.all(32))
          }
        }
        .frame(minHeight: 600)
        .padding()
        .modifier(CardView(fill: .F1Stats.systemYellow))
      }
      .onAppear(perform: viewModel.fetchRaceResults)
      .padding()
    }
  }

  func raceStandingsView(result: RaceResult) -> some View {
    HStack {
      Text(result.positionText)
        .frame(width: 20)
        .typography(type: .small(color: .F1Stats.systemDark))
      HStack {
        if (result.positionsShifted > 0) {
          Text( "+\(result.positionsShifted)")
            .typography(type: .small(color: .F1Stats.systemGreen))
        } else if (result.positionsShifted == 0) {
          Text( "\(result.positionsShifted)")
            .typography(type: .small(color: .F1Stats.systemDark))
        } else {
          Text("\(result.positionsShifted)")
            .typography(type: .small(color: .F1Stats.primary))
        }
      }
      .frame(width: 30)

      Text(result.driver.familyName)
        .typography(type: .body(color: .F1Stats.systemDark))
      Spacer()
      Text(result.constructor.name)
        .typography(type: .body(color: .F1Stats.systemDark))
    }
  }
}

#Preview {
  RaceResultsView(viewModel: RaceResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "1"))
}
