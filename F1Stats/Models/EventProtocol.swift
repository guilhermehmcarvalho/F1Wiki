//
//  EventProtocol.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 12/04/2024.
//

import Foundation

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
