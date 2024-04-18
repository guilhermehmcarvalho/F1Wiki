//
//  ConstructorsViewModelTests.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import XCTest
import Combine

@testable import F1Wiki

final class ConstructorsViewModelTests: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchInitialConstructors() {
    let viewModel = ConstructorsViewModel(apiConstructors: APIConstructorsStub(),
                                          wikipediaAPI: WikipediaAPIStub())
    let promise = expectation(description: "constructors will have been fetched")
    XCTAssertEqual(viewModel.constructorsList.count, 0, "Starting with no constructors")
    viewModel.fetchConstructors()
    viewModel.$constructorsList
      .sink() { constructors in
        if constructors.count > 0 {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

  func testFetchingMoreConstructors() {
    let viewModel = ConstructorsViewModel(apiConstructors: APIConstructorsStub(),
                                          wikipediaAPI: WikipediaAPIStub())

    let promise = expectation(description: "We will have more than one page of constructors")
    XCTAssertEqual(viewModel.constructorsList.count, 0, "Starting with no constructors")
    viewModel.fetchConstructors()
    viewModel.$constructorsList
      .sink() { constructors in
        if constructors.count > 0 {
          viewModel.fetchConstructors()
        }
        if constructors.count > 30 {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

}
