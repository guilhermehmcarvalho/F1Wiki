//
//  RaceViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class RaceViewModel: ObservableObject {

  internal let raceModel: RaceModel
  @Published internal var raceResultsViewModel: RaceResultsViewModel
  @Published internal var qualiResultsViewModel: QualiResultsViewModel
  @Published internal private(set) var animate: Bool = false

  @Published internal var presentingRaceResults: Bool = false
  @Published internal var presentingQualiResults: Bool = false

  @Published internal var raceCountdownViewModel: CountdownViewModel?
  @Published internal var qualiCountdownViewModel: CountdownViewModel?
  @Published internal var sprintCountdownViewModel: CountdownViewModel?
  @Published internal var practice1CountdownViewModel: CountdownViewModel?
  @Published internal var practice2CountdownViewModel: CountdownViewModel?
  @Published internal var practice3CountdownViewModel: CountdownViewModel?

  init<S: PassthroughSubject<Toast?, Never>>(raceModel: RaceModel, apiSeasons: APISeasonsProtocol, toastSubject: S? = nil) {
    self.raceModel = raceModel
    self.raceResultsViewModel = RaceResultsViewModel(apiSeasons: apiSeasons, 
                                                     round: raceModel.round,
                                                     year: raceModel.season,
                                                    toastSubject: toastSubject)
    self.qualiResultsViewModel = QualiResultsViewModel(apiSeasons: apiSeasons,
                                                       round: raceModel.round,
                                                       year: raceModel.season,
                                                       toastSubject: toastSubject)
    createCountdowns()
    handlePopupDismissal()
  }

  var title: String { raceModel.raceName }
  var circuit: String { raceModel.circuit.circuitName }
  var country: String { raceModel.circuit.location.country }
  var locality: String { raceModel.circuit.location.locality }
  var round: Int { Int(raceModel.round) ?? 0 }

  var fullDate: String {
    guard let firstDay = raceModel.firstPractice?.timeAsString(format: "d"),
          let lastDay = raceModel.timeAsString(format: "d MMM y") else {
      return ""
    }
    return "\(firstDay)-\(lastDay)"
  }

  internal func animate(_ animate: Bool, delay: Double = 0) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      withAnimation {
        self.animate = animate
      }
    }
  }

  private func handlePopupDismissal() {
    raceResultsViewModel.onDismissed = popupDismissed
    qualiResultsViewModel.onDismissed = popupDismissed
  }

  private func createCountdowns() {
    if let raceTime = raceModel.timeAsDate() {
      raceCountdownViewModel = CountdownViewModel(targetDate: raceTime)
    }

    if let time = raceModel.qualifying?.timeAsDate() {
      qualiCountdownViewModel = CountdownViewModel(targetDate: time)
    }

    if let time = raceModel.sprint?.timeAsDate() {
      sprintCountdownViewModel = CountdownViewModel(targetDate: time)
    }

    if let time = raceModel.firstPractice?.timeAsDate() {
      practice1CountdownViewModel = CountdownViewModel(targetDate: time)
    }

    if let time = raceModel.secondPractice?.timeAsDate() {
      practice2CountdownViewModel = CountdownViewModel(targetDate: time)
    }

    if let time = raceModel.thirdPractice?.timeAsDate() {
      practice3CountdownViewModel = CountdownViewModel(targetDate: time)
    }
  }

  func tappedRaceTicket() {
    if raceModel.isFinished() == false { return }
    presentingRaceResults.toggle()
  }

  func tappedQualiTicket() {
    if raceModel.qualifying?.isFinished() == false { return }
    presentingQualiResults.toggle()
  }

  private func popupDismissed() {
    presentingRaceResults = false
    presentingQualiResults = false
  }
}

extension RaceViewModel: Identifiable {
  var id: String {
    raceModel.round
  }
}

extension RaceViewModel: Hashable, Equatable {
  static func == (lhs: RaceViewModel, rhs: RaceViewModel) -> Bool {
    lhs.round == rhs.round
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(round)
  }
}
