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
        VStack{
          title("\(raceModel.raceName)")
            .padding(.top(6))
          VStack {
            Text("Qualifying Result")
              .typography(type: .heading(color: .F1Stats.primary))

              ForEach(Array(viewModel.qualiResults.enumerated()), id: \.element.driver) { (index, result) in

                standingsRow(result: result)
                  .modifier(DriverCardDisplayer(driver: result.driver))
                  .padding(.vertical(2))

            }
          }.padding(16)
        }
      }
    }
    .frame(minHeight: 600)
    .cardStyling()
    .padding(.all(8))
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
          .clickableUnderline()
        Text(result.constructor.name)
          .typography(type: .body(color: .F1Stats.appDark))
          .modifier(ConstructorCardDisplayer(constructor: result.constructor))
          .clickableUnderline()
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


  func title(_ title: String) -> some View {
    ZStack {
      Color.F1Stats.primary

      Text(title)
        .textCase(.uppercase)
        .typography(type: .heading(color: .F1Stats.appWhite))
        .padding(.all(4))
        .multilineTextAlignment(.center)
    }
    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
  }
}

#Preview {
  QualiResultsView(viewModel: QualiResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "1"))
}
