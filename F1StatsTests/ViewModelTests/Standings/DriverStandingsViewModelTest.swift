//
//  DriverStandingsViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import XCTest
import Combine

@testable import F1Wiki

final class DriverStandingsViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchDriverStandings() {
    let viewModel = DriverStandingsViewModel(apiSeasons: APISeasonsStub())
    let promise = expectation(description: "Will fetch standings")
    XCTAssertNil(viewModel.driverStandings, "Starting with no standings")
    viewModel.fetchDriverStandings()
    viewModel.$driverStandings
      .sink() { standings in
        if standings != nil {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

}
