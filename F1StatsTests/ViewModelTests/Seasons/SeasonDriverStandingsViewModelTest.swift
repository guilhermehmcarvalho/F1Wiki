//
//  SeasonDriverStandingsViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import XCTest
import Combine
@testable import F1Wiki

final class SeasonDriverStandingsViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchDriverStandings() {
    let viewModel = SeasonDriverStandingsViewModel(seasonId: "2024", apiSeasons: APISeasonsStub())
    let promise = expectation(description: "Standings will have been fetched")
    XCTAssertNil(viewModel.standingLists, "Starting with no standings")
    viewModel.fetchStandings()
    viewModel.$standingLists
      .sink() { seasons in
        if seasons != nil {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }
}
