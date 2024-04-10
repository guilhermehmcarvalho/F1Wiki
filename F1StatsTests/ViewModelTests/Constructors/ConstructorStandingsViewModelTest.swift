//
//  ConstructorStandingsViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import XCTest
import Combine
@testable import F1Stats

final class ConstructorStandingsViewModelTest: XCTestCase {


  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchConstructorStandings() {
    let viewModel = ConstructorStandingsRowViewModel(constructorId: "ferrari", apiConstructors: APIConstructorsStub())
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
