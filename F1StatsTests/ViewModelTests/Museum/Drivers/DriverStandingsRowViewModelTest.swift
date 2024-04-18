//
//  DriverStandingsRowViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import XCTest
import Combine

@testable import F1Wiki

final class DriverStandingsRowViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchDriverStandings() {
    let viewModel = DriverStandingsRowViewModel(driverId: "Senna", driverApi: APIDriversStub())
    let promise = expectation(description: "Will fetch standings")
    XCTAssertNil(viewModel.standingLists, "Starting with no standings")
    viewModel.fetchStandings()
    viewModel.$standingLists
      .sink() { standings in
        if standings != nil {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

}
