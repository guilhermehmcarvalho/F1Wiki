//
//  CountdownViewModel.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 18/04/2024.
//

import Foundation
import Combine

class CountdownViewModel: ObservableObject {
  let targetDate: Date

  @Published var days: String?
  @Published var hours: String?
  @Published var minutes: String?

  init(targetDate: Date) {
    self.targetDate = targetDate
  }

  var countdown: DateComponents {
    return Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: targetDate)
  }

  @objc func updateTime() {
    let countdown = self.countdown

    if let days = countdown.day {
      self.days = String(days)
    }
    if let hours = countdown.hour {
      self.hours = String(hours)
    }
    if let minutes = countdown.minute {
      self.minutes = String(minutes)
    }
  }

  func runCountdown() {
    updateTime() // avoids having a delay on setting the initial date
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
  }
}
