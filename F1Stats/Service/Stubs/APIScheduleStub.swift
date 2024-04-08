//
//  APIScheduleStub.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation
import Combine

class APIScheduleStub: APIScheduleProtocol {
  let delay: Double

  init(delay: Double = 0) {
    self.delay = delay
  }

  func currentSeasonSchedule(limit: Int = 30, offset: Int = 0) -> AnyPublisher<MRData<RaceTable>, any Error> {
    guard let path = Bundle.main.path(forResource: "currentSeasonSchedule", ofType: "json") else {
      return Empty().eraseToAnyPublisher()
    }

    do {
      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let model = try JSONDecoder().decode(MRData<RaceTable>.self, from: jsonData)
      return Just(model)
        .delay(for: .seconds(delay), scheduler: RunLoop.main)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    } catch let error {
      print(error)
      return Empty().eraseToAnyPublisher()
    }
  }
  
  
}
