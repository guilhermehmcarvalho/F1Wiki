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

  @Published var presentingRaceResults: Bool = false
  @Published var presentingQualiResults: Bool = false

  init(raceModel: RaceModel, apiSeasons: APISeasonsProtocol) {
    self.raceModel = raceModel
    self.raceResultsViewModel = RaceResultsViewModel(apiSeasons: apiSeasons, 
                                                     round: raceModel.round,
                                                     year: raceModel.season)
    self.qualiResultsViewModel = QualiResultsViewModel(apiSeasons: apiSeasons,
                                                       round: raceModel.round,
                                                       year: raceModel.season)
    raceResultsViewModel.onDismissed = popupDismissed
    qualiResultsViewModel.onDismissed = popupDismissed
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
