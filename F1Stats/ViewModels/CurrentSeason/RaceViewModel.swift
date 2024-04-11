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
  @Published internal private(set) var animate: Bool = false

  @Published var presentingRaceResults: Bool = false

  init(raceModel: RaceModel, apiSeasons: APISeasonsProtocol) {
    self.raceModel = raceModel
    self.raceResultsViewModel = RaceResultsViewModel(apiSeasons: apiSeasons, round: raceModel.round, year: raceModel.season)
    raceResultsViewModel.onDismissed = resultsDismissed
  }

  var title: String { raceModel.raceName }
  var circuit: String { raceModel.circuit.circuitName }
  var country: String { raceModel.circuit.location.country }
  var locality: String { raceModel.circuit.location.locality }
  var round: Int { Int(raceModel.round) ?? 0 }

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

  private func resultsDismissed() {
    presentingRaceResults = false
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

extension EventModule: EventProtocol { }
extension RaceModel: EventProtocol { }

protocol EventProtocol {
  var date: String { get }
  var time: String { get }
}

extension EventProtocol {
  func timeAsDate() -> Date? {
    let dateString = self.date.appending(time)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ssZ"
    return dateFormatter.date(from: dateString)
  }

  func timeAsString() -> String? {
    guard let date = timeAsDate() else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.dateFormat = "E, d MMM y HH:mm "
    return formatter.string(from: date)
  }

  func isFinished(durationInMinutes: Double = 120) -> Bool {
    guard let eventTime = timeAsDate() else {
      return true
    }
    return eventTime.addingTimeInterval(durationInMinutes) < Date.now
  }
}
