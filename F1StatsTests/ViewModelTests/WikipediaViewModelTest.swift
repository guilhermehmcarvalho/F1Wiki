//
//  WikipediaViewModelTest.swift
//  F1StatsTests
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import XCTest
import Combine

@testable import F1Wiki

final class WikipediaViewModelTest: XCTestCase {

  var subscriptions = Set<AnyCancellable>()

  override func tearDown() {
    subscriptions = []
  }

  func testFetchArticle() {
    let viewModel = WikipediaViewModel(url: "", wikipediaApi: WikipediaAPIStub())
    let promise = expectation(description: "Summary was fetch'd")
    XCTAssertNil(viewModel.summaryModel, "Summary is not empty")
    viewModel.fetchSummary()
    viewModel.$summaryModel.sink() { summary in
      if summary != nil {
        promise.fulfill()
      }
    }.store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

  func testFetchWikiMediaList() {
    let viewModel = WikipediaViewModel(url: "", wikipediaApi: WikipediaAPIStub())
    let promise = expectation(description: "Media was fetch'd")
    XCTAssertNil(viewModel.mediaList, "Media is not empty")
    viewModel.fetchMediaList()
    viewModel.$mediaList.sink() { media in
      if media != nil {
        promise.fulfill()
      }
    }.store(in: &subscriptions)

    wait(for: [promise], timeout: 1)
  }

}
