//
//  QualiResultsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 12/04/2024.
//

import SwiftUI

struct QualiResultsView: View {

  @ObservedObject var viewModel: QualiResultsViewModel

  var sortedResults: [EnumeratedSequence<[QualifyingResult]>.Element] {
    let results = (viewModel.raceModel?.qualifyingResults ?? []).enumerated()
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
          standingsRow(result: result)
          if index < sortedResults.count - 1 {
            Divider().padding(.all(0))
          }
        }
      }
    }
    .frame(minHeight: 600)
    .padding(.all(8))
    .modifier(CardView(fill: .F1Stats.systemYellow))
    .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 8))
    .onAppear(perform: viewModel.fetchQualiResult)
  }

  func standingsRow(result: QualifyingResult) -> some View {
    HStack(alignment: .center) {
      Text(result.position)
        .frame(width: 20)
        .typography(type: .small(color: .F1Stats.systemDark))

      Text(result.driver.familyName)
        .typography(type: .body(color: .F1Stats.systemDark))
      Spacer()
      Text(result.constructor.name)
        .typography(type: .body(color: .F1Stats.systemDark))
    }
  }
}

#Preview {
  QualiResultsView(viewModel: QualiResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "1"))
}
