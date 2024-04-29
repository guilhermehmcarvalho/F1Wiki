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
        VStack{
          CardStyling.makeCardTitle("\(raceModel.raceName)")
            .padding(.top(6))
          VStack {
            Text("Race Result")
              .typography(type: .heading(color: .F1Stats.primary))
            
            header
              .padding(.vertical(8))
            
            if let raceResults = raceModel.raceResults {
              ForEach(Array(raceResults.enumerated()), id: \.element.driver) { (index, result) in
                raceStandingsRow(result: result)
                  .modifier(DriverCardDisplayer(driver: result.driver))
                  .padding(.vertical(2))
              }
            }
          }.padding(16)
        }
      }
    }
    .padding(.trailing(8))
    .frame(minHeight: 600)
    .cardStyling()
    .padding(.all(8))
    .onAppear(perform: viewModel.fetchRaceResults)
  }

  var header: some View {
    HStack {
      Text("Pos")
        .typography(type: .body())
        .frame(width: 60)

      Text("Driver/Team")
        .typography(type: .body())

      Spacer()

      Text("Points")
        .typography(type: .body())
        .frame(width: 50)
    }
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
      Text(result.points)
        .frame(width: 50)
        .typography(type: .body())
    }
  }
}

#Preview {
  RaceResultsView(viewModel: RaceResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "1"))
}
