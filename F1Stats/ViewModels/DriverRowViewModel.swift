//
//  DriverRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI
import Combine

class DriverRowViewModel: ExpandableRowViewModel, ObservableObject {
  let driver: DriverModel
  let wikipediaApi: WikipediaAPIProtocol
  @Published var expandedView: AnyView = AnyView(Group{})
  @Published var wikipediaData: WikipediaSummaryModel?
  @Published var isExpanded = false
  private var cancellable: AnyCancellable?

  init(driver: DriverModel, wikipediaApi: WikipediaAPIProtocol) {
    self.driver = driver
    self.wikipediaApi = wikipediaApi
  }

  var mainView: AnyView {
    AnyView(
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
          Text(driver.familyName)
            .textCase(.uppercase)
            .typography(type: .heading())
          Text(driver.givenName)
            .typography(type: .small())
          Spacer()
        }
        AnyView(
          Text(driver.nationality)
            .typography(type: .small())
        )
      }
    )
  }

  internal func onTap() {
    isExpanded = !isExpanded

    if isExpanded && wikipediaData == nil {
      requestSummary()
    }

    setExpandedView()
  }

  private func setExpandedView() {
    var currentView: any View

    if !isExpanded {
      currentView = AnyView(Group{})
    } else {
      if let wikipediaData = wikipediaData {
        currentView = WikipediaView(
          wikipediaViewModel: WikipediaViewModel(fromSummary: wikipediaData)
        )
        .padding(.all(16))
      } else {
        currentView = Text("Loading")
          .typography(type: .body())
      }
    }

    expandedView = AnyView(currentView)
  }

  private func requestSummary() {
    cancellable = wikipediaApi.getSummaryFor(url: driver.url)
      .receive(on: DispatchQueue.main)
      .sink { error in
        print(error)
      } receiveValue: { [weak self] response in
        self?.wikipediaData = response
        self?.setExpandedView()
      }
  }

}

extension DriverRowViewModel {
  static var stub = DriverRowViewModel(driver: DriverModel.stub, 
                                       wikipediaApi: WikipediaAPIStub())
}
