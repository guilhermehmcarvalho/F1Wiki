//
//  RaceViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation
import Combine
import UIKit

class RaceViewModel: ObservableObject {

  let raceModel: RaceModel
  @Published internal var animate = false

  init(raceModel: RaceModel) {
    self.raceModel = raceModel
  }

  var title: String { raceModel.raceName }
  var circuit: String { raceModel.circuit.circuitName }
  var country: String { raceModel.circuit.location.country }
  var locality: String { raceModel.circuit.location.locality }
  var round: String { raceModel.round }
  
  var raceDate: Date? {
    dateFromString(raceModel.date.appending(raceModel.time))
  }

  var raceDateString: String? {
    dateToString(date: raceDate)
  }

  var practice1Date: Date? {
    dateFromString(raceModel.firstPractice.date.appending(raceModel.firstPractice.time))
  }

  var practice1DateString: String? {
    dateToString(date: practice1Date)
  }

  var practice2Date: Date? {
    dateFromString(raceModel.secondPractice.date.appending(raceModel.secondPractice.time))
  }

  var practice2DateString: String? {
    dateToString(date: practice2Date)
  }

  var practice3Date: Date? {
    dateFromString(raceModel.thirdPractice?.date.appending(raceModel.thirdPractice?.time ?? ""))
  }

  var practice3DateString: String? {
    dateToString(date: practice3Date)
  }

  var qualiDate: Date? {
    dateFromString(raceModel.qualifying.date.appending(raceModel.qualifying.time))
  }

  var qualiDateString: String? {
    dateToString(date: qualiDate)
  }

  var sprintDate: Date? {
    dateFromString(raceModel.sprint?.date.appending(raceModel.sprint?.time ?? ""))
  }

  var sprintDateString: String? {
    dateToString(date: sprintDate)
  }

  private func dateFromString(_ dateString: String?) -> Date? {
    guard let dateString = dateString else { return nil }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ssZ"
    return dateFormatter.date(from: dateString)
  }

  private func dateToString(date: Date?) -> String? {
    guard let date = date else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.dateFormat = "E, d MMM y \nHH:mm "
    return formatter.string(from: date)
  }
}
