//
//  ScheduleViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 08/04/2024.
//


import XCTest
import Combine
@testable import F1Stats

final class RacesViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchCurrentSchedule() {
    let viewModel = RacesViewModel(apiSchedule: APIScheduleStub(), wikipediaAPI: WikipediaAPIStub())
    let promise = expectation(description: "Races will have been fetched")
    XCTAssertEqual(viewModel.raceList.count, 0, "Starting with no races")
    viewModel.fetchCurrentSchedule()
    viewModel.$raceList
      .sink() { races in
        if races.count > 0 {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }
}
