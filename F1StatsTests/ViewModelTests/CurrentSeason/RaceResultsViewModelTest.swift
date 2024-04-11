//
//  RaceResultsViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 10/04/2024.
//

import XCTest
import Combine
@testable import F1Stats

final class RaceResultsViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchCurrentSchedule() {
    let viewModel = RaceResultsViewModel(apiSeasons: APISeasonsStub(), round: "1", year: "2024")
    let promise = expectation(description: "Results will have been fetched")
    XCTAssertNil(viewModel.raceModel?.raceResults, "Starting with no results")
    viewModel.fetchRaceResults()
    viewModel.$raceModel
      .sink() { result in
        if result?.raceResults != nil {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }
}
