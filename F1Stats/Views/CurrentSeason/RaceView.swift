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

          grandPrix
            .frame(maxWidth: .infinity, minHeight: geo.size.width/2)
            .raceTicket()
            .zIndex(5)
            .ticketTransition()

          quali
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(4)
            .ticketTransition()

          if (viewModel.raceModel.thirdPractice != nil) {
            practice3
              .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
              .raceTicket()
              .zIndex(3)
              .ticketTransition()
          }
          if (viewModel.raceModel.sprint != nil) {
            sprint
              .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
              .raceTicket()
              .zIndex(2)
              .ticketTransition()
          }

          practice2
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(1)
            .ticketTransition()

          practice1
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(0)
            .ticketTransition()
        }
        .safeAreaPadding()
      }
    }
  }

  var grandPrix: some View {
    ZStack {
      VStack {
        Text("Round \(viewModel.round)")
          .typography(type: .small(color: .F1Stats.primary))
        Text(viewModel.title)
          .typography(type: .heading(color: .F1Stats.primary))
        Text(viewModel.circuit)
          .typography(type: .body(color: .F1Stats.systemDark))
        if let raceDate = viewModel.raceModel.timeAsString() {
          Spacer().frame(height: 16)
          Text(raceDate)
            .multilineTextAlignment(.center)
            .typography(type: .body(color: .F1Stats.systemDark))
        }
        if viewModel.raceModel.isFinished() {
          Text("View results")
            .multilineTextAlignment(.center)
            .typography(type: .body(color: .F1Stats.primary))
        }
      }

      if viewModel.raceModel.isFinished() {
        Text("FINISHED")
          .font(.dlsFont(size: 50, weight: .black))
          .foregroundColor(.F1Stats.primary.opacity(0.05))
      }
    }
  }

  var practice1: some View {
    VStack {
      Text("Free Practice 1")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.raceModel.firstPractice?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }

  var practice2: some View {
    VStack {
      Text("Free Practice 2")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.raceModel.secondPractice?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }

  var practice3: some View {
    VStack {
      Text("Free Practice 3")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.raceModel.thirdPractice?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }

  var sprint: some View {
    VStack {
      Text("Sprint")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.raceModel.sprint?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }

  var quali: some View {
    VStack {
      Text("Qualifying")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.raceModel.qualifying?.timeAsString() {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }

      if viewModel.raceModel.isFinished() {
        Text("View results")
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.primary))
      }
    }
  }
}

fileprivate extension View {
  func raceTicket() -> some View {
    self
      .modifier(TicketView(cornerRadius: 12, fill: .F1Stats.systemYellow))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .strokeBorder(Color.F1Stats.primary, lineWidth: 4)
          .padding(12)
      )
  }

  func ticketTransition() -> some View {
    let range = 4
    let randomAngle = Angle(degrees: Double(Int.random(in: -range..<range)))
    return self
      .scrollTransition { content, phase in
        content
          .scaleEffect(phase.isIdentity ? 1.0 : 0.5)
          .rotationEffect(phase.isIdentity ? randomAngle : Angle(degrees: 10))
      }
  }
}
