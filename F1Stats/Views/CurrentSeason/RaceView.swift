//
//  RaceView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import SwiftUI
import Combine

struct RaceView: View {
  
  @ObservedObject var viewModel: RaceViewModel

  init(viewModel: RaceViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    GeometryReader { geo in
      ScrollView(showsIndicators: false) {
        VStack(spacing: viewModel.animate ? 0 : -250) {

          topCard
            .frame(maxWidth: .infinity, minHeight: geo.size.width/2)
            .makeCardView()
            .zIndex(6)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.F1Stats.primary, lineWidth: 4)
                .padding(8)
            )
            .twistingTransition(finalAngle: 0)
            .padding(.horizontal(16))
            .padding(.vertical(8))

          grandPrix
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(5)
            .twistingTransition(finalAngle: -1)
            .onTapGesture(perform: viewModel.tappedRaceTicket)
            .fullScreenCover(isPresented: $viewModel.presentingRaceResults) {
              CustomSheet {
                RaceResultsView(viewModel: viewModel.raceResultsViewModel)
                  
              } dismiss: {
                viewModel.presentingRaceResults = false
              }
            }

          quali
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(4)
            .twistingTransition(finalAngle: 1)
            .onTapGesture(perform: viewModel.tappedQualiTicket)
            .fullScreenCover(isPresented: $viewModel.presentingQualiResults) {
              CustomSheet {
                QualiResultsView(viewModel: viewModel.qualiResultsViewModel)
              } dismiss: {
                viewModel.presentingQualiResults = false
              }
            }

          if (viewModel.raceModel.thirdPractice != nil) {
            practice3
              .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
              .raceTicket()
              .zIndex(3)
              .twistingTransition(finalAngle: 0)
          }

          if (viewModel.raceModel.sprint != nil) {
            sprint
              .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
              .raceTicket()
              .zIndex(2)
              .twistingTransition(finalAngle: 0)
          }

          practice2
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(1)
            .twistingTransition(finalAngle: -2)

          practice1
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(0)
            .twistingTransition(finalAngle: 2)
        }
        .safeAreaPadding()
      }
    }
  }

  var topCard: some View {
    ZStack {
      VStack {
        if let flag = SwiftFlags.flag(for: viewModel.country) {
          Text(flag)
        }
        Text("Round \(viewModel.round)")
          .typography(type: .small(color: .F1Stats.primary))
        Text(viewModel.title)
          .typography(type: .heading(color: .F1Stats.primary))
        Text(viewModel.circuit)
          .typography(type: .body(color: .F1Stats.appDark))
        Text(viewModel.locality)
          .typography(type: .body(color: .F1Stats.appDark))

          Spacer().frame(height: 16)

          Text(viewModel.fullDate)
            .multilineTextAlignment(.center)
            .typography(type: .body(color: .F1Stats.appDark))
      }

      if viewModel.raceModel.isFinished() {
        Text("FINISHED")
          .font(.dlsFont(size: 50, weight: .black))
          .foregroundColor(.F1Stats.primary.opacity(0.05))
      }
    }
  }


  var grandPrix: some View {
    VStack {
      Text("Feature Race")
        .typography(type: .subHeader (color: .F1Stats.primary))
      if let date = viewModel.raceModel.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.appDark))
      }

      if viewModel.raceModel.isFinished() {
        Text("View results")
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.primary))
          .clickableUnderline(color: .F1Stats.primary)
      } else if let vm = viewModel.raceCountdownViewModel {
        CountdownView(viewModel: vm)
      }
    }
  }

  var practice1: some View {
    VStack {
      Text("Free Practice 1")
        .typography(type: .subHeader (color: .F1Stats.appDark))
      if let date = viewModel.raceModel.firstPractice?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.appDark))
      }
      if viewModel.raceModel.firstPractice?.isFinished() == false,
          let vm = viewModel.practice1CountdownViewModel {
        CountdownView(viewModel: vm)
      }
    }
  }

  var practice2: some View {
    VStack {
      Text(viewModel.raceModel.sprint == nil ? "Free Practice 2" : "Sprint Qualifying")
        .typography(type: .subHeader (color: .F1Stats.appDark))
      if let date = viewModel.raceModel.secondPractice?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.appDark))
      }
      if viewModel.raceModel.secondPractice?.isFinished() == false,
          let vm = viewModel.practice2CountdownViewModel {
        CountdownView(viewModel: vm)
      }
    }
  }

  var practice3: some View {
    VStack {
      Text("Free Practice 3")
        .typography(type: .subHeader (color: .F1Stats.appDark))
      if let date = viewModel.raceModel.thirdPractice?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.appDark))
      }
      if viewModel.raceModel.thirdPractice?.isFinished() == false,
          let vm = viewModel.practice3CountdownViewModel {
        CountdownView(viewModel: vm)
      }
    }
  }

  var sprint: some View {
    VStack {
      Text("Sprint")
        .typography(type: .subHeader (color: .F1Stats.primary))
      if let date = viewModel.raceModel.sprint?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.appDark))
      }
      if viewModel.raceModel.sprint?.isFinished() == false,
          let vm = viewModel.sprintCountdownViewModel {
        CountdownView(viewModel: vm)
      }
    }
  }

  var quali: some View {
    VStack {
      Text("Qualifying")
        .typography(type: .subHeader (color: .F1Stats.primary))
      if let date = viewModel.raceModel.qualifying?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.appDark))
      }

      if viewModel.raceModel.isFinished() {
        Text("View results")
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.primary))
          .clickableUnderline(color: .F1Stats.primary)
      } else if let vm = viewModel.qualiCountdownViewModel {
        CountdownView(viewModel: vm)
      }
    }
  }
}

fileprivate extension View {
  func raceTicket() -> some View {
    self
      .modifier(TicketView(cornerRadius: 12, fill: .F1Stats.appYellow))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .strokeBorder(Color.F1Stats.primary, lineWidth: 4)
          .padding(12)
      )
  }
}
