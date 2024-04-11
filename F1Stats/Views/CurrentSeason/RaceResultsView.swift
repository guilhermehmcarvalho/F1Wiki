//
//  RaceResultsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 11/04/2024.
//

import SwiftUI

struct RaceResultsView: View {
  
  @ObservedObject var viewModel: RaceResultsViewModel
  @State var position: CGPoint = .zero

  var sortedResults: [EnumeratedSequence<[RaceResult]>.Element] {
    let results = (viewModel.raceModel?.raceResults ?? []).enumerated()
    return results.sorted { Int($0.element.position)! < Int($1.element.position)! }
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

        if let raceModel = viewModel.raceModel {
          Text("\(raceModel.raceName) Result")
            .typography(type: .heading(color: .F1Stats.primary))
            .padding()

          ForEach(sortedResults, id: \.element.driver) { index, result in
            raceStandingsRow(result: result)
            if index < sortedResults.count - 1 {
              Divider().padding(.all(0))
            }
          }
        }

      }
      .onPreferenceChange(PreferenceKey.self) { position in
        self.position = position
      }

      .frame(minHeight: 600)
      .padding(.all(8))
      .modifier(CardView(fill: .F1Stats.systemYellow))
      .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 8))

    .onAppear(perform: viewModel.fetchRaceResults)
  }

  func raceStandingsRow(result: RaceResult) -> some View {
    HStack(alignment: .center) {
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
