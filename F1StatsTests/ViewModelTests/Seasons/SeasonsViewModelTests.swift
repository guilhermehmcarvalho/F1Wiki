//
//  SeasonsViewModelTests.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import XCTest
import Combine

@testable import F1Wiki

final class SeasonsViewModelTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()

    override func tearDown() {
      subscriptions = []
    }

    func testFetchInitialSeasons() {
      let viewModel = SeasonsViewModel(apiSeasons: APISeasonsStub(), wikipediaAPI: WikipediaAPIStub())
      let promise = expectation(description: "seasons will have been fetched")
      XCTAssertEqual(viewModel.seasonsList.count, 0, "Starting with no seasons")
      viewModel.fetchSeasons()
      viewModel.$seasonsList
        .sink() { seasons in
          if seasons.count > 0 {
            promise.fulfill()
          }
        }
        .store(in: &subscriptions)

      wait(for: [promise], timeout: 1)
    }

    func testFetchingMoreSeasons() {
      let viewModel = SeasonsViewModel(apiSeasons: APISeasonsStub(), wikipediaAPI: WikipediaAPIStub())

      let promise = expectation(description: "We will have more than one page of seasons")
      XCTAssertEqual(viewModel.seasonsList.count, 0, "Starting with no seasons")
      viewModel.fetchSeasons()
      viewModel.$seasonsList
        .sink() { seasons in
          if seasons.count > 0 {
            viewModel.fetchSeasons()
          }
          if seasons.count > 30 {
            promise.fulfill()
          }
        }
        .store(in: &subscriptions)

      wait(for: [promise], timeout: 1)
    }

  }
