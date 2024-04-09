//
//  ConstructorRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation
import SwiftUI
import Combine

class ConstructorRowViewModel: ObservableObject {
  internal let constructor: ConstructorModel
  private var apiConstructor: APIConstructorsProtocol
  @Published internal var wikipediaViewModel: WikipediaViewModel

  init(constructor: ConstructorModel, wikipediaApi: WikipediaAPIProtocol, apiConstructor: APIConstructorsProtocol) {
    self.constructor = constructor
    self.apiConstructor = apiConstructor
    self.wikipediaViewModel = WikipediaViewModel(url: constructor.url, wikipediaApi: wikipediaApi)
  }

  internal var constructorStandingsRowViewModel: ConstructorStandingsRowViewModel {
    ConstructorStandingsRowViewModel(constructorId: constructor.constructorID, apiConstructors: apiConstructor)
  }
}
