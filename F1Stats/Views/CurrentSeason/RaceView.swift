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
  var wikipediaViewModel: WikipediaViewModel
  @State private var animate = false

  init(viewModel: RaceViewModel) {
    self.viewModel = viewModel
    self.wikipediaViewModel = WikipediaViewModel(url: viewModel.raceModel.url, wikipediaApi: WikipediaAPI(baseURL: Config.wikipediaURL))
  }

  var body: some View {
    GeometryReader { geo in
      ScrollView(showsIndicators: false) {
        VStack(spacing: animate ? 0 : -300) {

          grandPrix
            .frame(maxWidth: .infinity, minHeight: geo.size.width/2)
            .raceTicket()
            .zIndex(5)
            .rotationEffect(animate ?
                            Angle(degrees: Double(Int.random(in: -4..<4))) : Angle(degrees: 0))

          quali
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(4)
            .rotationEffect(animate ?
                            Angle(degrees: Double(Int.random(in: -4..<4))) : Angle(degrees: 0))

          if (viewModel.raceModel.thirdPractice != nil) {
            practice3
              .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
              .raceTicket()
              .zIndex(3)
              .rotationEffect(animate ?
                              Angle(degrees: Double(Int.random(in: -4..<4))) : Angle(degrees: 0))
          }
          if (viewModel.raceModel.sprint != nil) {
            sprint
              .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
              .raceTicket()
              .zIndex(2)
              .rotationEffect(animate ?
                              Angle(degrees: Double(Int.random(in: -4..<4))) : Angle(degrees: 0))
          }

          practice2
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(1)
            .rotationEffect(animate ?
                            Angle(degrees: Double(Int.random(in: -4..<4))) : Angle(degrees: 0))

          practice1
            .frame(maxWidth: geo.size.width/1.5, minHeight: (geo.size.width/1.5)/1.8)
            .raceTicket()
            .zIndex(0)
            .rotationEffect(animate ?
                            Angle(degrees: Double(Int.random(in: -2..<2))) : Angle(degrees: 0))
        }
        .animation(.snappy (duration: 1), value: animate)
        .padding(.top)
        .safeAreaPadding()
      }
    }
    .onAppear { animate = true }
  }

  var grandPrix: some View {
    VStack {
      Text("Round \(viewModel.round)")
        .typography(type: .small(color: .F1Stats.primary))
      Text(viewModel.title)
        .typography(type: .heading(color: .F1Stats.primary))
      Text(viewModel.circuit)
        .typography(type: .body(color: .F1Stats.systemDark))
      if let raceDate = viewModel.raceDateString {
        Spacer().frame(height: 16)
        Text(raceDate)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }

  var practice1: some View {
    VStack {
      Text("Free Practice 1")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.practice1DateString {
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
      if let date = viewModel.practice2DateString {
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
      if let date = viewModel.practice3DateString {
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
      if let date = viewModel.sprintDateString {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }

  var quali: some View {
    VStack {
      Text("Qualification")
        .typography(type: .subHeader (color: .F1Stats.systemDark))
      if let date = viewModel.qualiDateString {
        Spacer().frame(height: 4)
        Text(date)
          .multilineTextAlignment(.center)
          .typography(type: .body(color: .F1Stats.systemDark))
      }
    }
  }
}

fileprivate extension View {
  func raceTicket() -> some View {
    self
      .modifier(TicketView(cornerRadius: 12, fill: .yellow))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .strokeBorder(Color.F1Stats.primary, lineWidth: 4)
          .padding(12)
      )
  }
}
