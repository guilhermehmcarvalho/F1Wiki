//
//  DriversViewModelTests.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import XCTest
import Combine

@testable import F1Wiki

final class DriversViewModelTests: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchInitialDrivers() {
    let viewModel = DriversViewModel(driverApi: APIDriversStub(), wikipediaAPI: WikipediaAPIStub())
    let promise = expectation(description: "drivers will have been fetched")
    XCTAssertEqual(viewModel.driverList.count, 0, "Starting with no drivers")
    viewModel.fetchDrivers()
    viewModel.$driverList
      .sink() { drivers in
        if drivers.count > 0 {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

  func testFetchingMoreDrivers() {
    let viewModel = DriversViewModel(driverApi: APIDriversStub(), wikipediaAPI: WikipediaAPIStub())

    let promise = expectation(description: "We will have more than one page of drivers")
    XCTAssertEqual(viewModel.driverList.count, 0, "Starting with no drivers")
    viewModel.fetchDrivers()
    viewModel.$driverList
      .sink() { drivers in
        if drivers.count > 0 {
          viewModel.fetchDrivers()
        }
        if drivers.count > 30 {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

}
