//
//  ScheduleViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 08/04/2024.
//


import XCTest
import Combine
@testable import F1Stats

final class CurrentSeasonViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchCurrentSchedule() {
    let viewModel = CurrentSeasonViewModel(apiSeasons: APISeasonsStub(), wikipediaAPI: WikipediaAPIStub())
    let promise = expectation(description: "Races will have been fetched")
    XCTAssertEqual(viewModel.raceList.count, 0, "Starting with no races")
    viewModel.fetchCurrentSchedule()
    viewModel.$selectedRace
      .sink() { selectedRace in
        if selectedRace != nil {
          promise.fulfill()
        }
      }
      .store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }
}
