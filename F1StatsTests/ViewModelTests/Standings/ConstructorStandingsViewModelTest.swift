//
//  ConstructorStandingsViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import XCTest
import Combine
@testable import F1Wiki

final class ConstructorStandingsViewModelTest: XCTestCase {

var subscriptions = Set<AnyCancellable>()

override func tearDown() {
  subscriptions = []
}

func testFetchConstructorStandings() {
  let viewModel = ConstructorStandingsViewModel(apiSeasons: APISeasonsStub())
  let promise = expectation(description: "Will fetch standings")
  XCTAssertNil(viewModel.constructorStandings, "Starting with no standings")
  viewModel.fetchConstructorStandings()
  viewModel.$constructorStandings
    .sink() { standings in
      if standings != nil {
        promise.fulfill()
      }
    }
    .store(in: &subscriptions)

  wait(for: [promise], timeout: 1)
}


}
