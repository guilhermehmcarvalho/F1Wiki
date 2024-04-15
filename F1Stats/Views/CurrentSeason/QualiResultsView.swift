//
//  QualiResultsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 12/04/2024.
//

import SwiftUI

struct QualiResultsView: View {

  @ObservedObject var viewModel: QualiResultsViewModel

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
          Text("Qualifying Result")
            .typography(type: .heading(color: .F1Stats.primary))
        }.padding(.all(8))

        ForEach(Array(viewModel.qualiResults.enumerated()), id: \.element.driver) { index, result in
          standingsRow(result: result)
          if index < viewModel.qualiResults.count - 1 {
            Divider().padding(.all(0))
          }
        }
      }
    }
    .frame(minHeight: 600)
    .padding(.all(8))
    .modifier(CardView(fill: .F1Stats.appWhite))
    .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 8))
    .onAppear(perform: viewModel.fetchQualiResult)
  }

  func standingsRow(result: QualifyingResult) -> some View {

    HStack(alignment: .center) {
      Text(result.position)
        .frame(width: 30)
        .typography(type: .body(color: .F1Stats.appDark))
      VStack(alignment: .leading) {
        Text(result.driver.fullName)
          .typography(type: .subHeader(color: .F1Stats.appDark))
        Text(result.constructor.name)
          .typography(type: .body(color: .F1Stats.appDark))
      }

      Spacer()

      VStack(alignment: .trailing) {
        if let q3 = result.q3 {
          HStack {
            Text("Q3")
              .typography(type: .small(color: .F1Stats.appDark))
            Text(q3)
              .typography(type: .small(color: .F1Stats.appDark))
          }
        }
        if let q2 = result.q2 {
          HStack {
            Text("Q2")
              .typography(type: .small(color: .F1Stats.appDark))
            Text(q2)
              .typography(type: .small(color: .F1Stats.appDark))
          }
        }
          HStack {
            Text("Q1")
              .typography(type: .small(color: .F1Stats.appDark))
            Text(result.q1)
              .typography(type: .small(color: .F1Stats.appDark))
          }
      }
    }
  }
}

#Preview {
  QualiResultsView(viewModel: QualiResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "1"))
}
