//
//  ConstructorCardDisplayer.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import SwiftUI

// At the moment dependency injection in this view is not being enforced in this view
// as it would generate basically too much boilerplate, since this view can be called from
// almost the whole app
struct ConstructorCardDisplayer: ViewModifier {
  let constructor: ConstructorModel
  let wikipediaApi: WikipediaAPIProtocol
  let constructorAPI: APIConstructorsProtocol

  init(constructor: ConstructorModel,
       constructorAPI: APIConstructorsProtocol = APIConstructors(baseURL: Config.baseURL),
       wikipediaApi: WikipediaAPIProtocol = WikipediaAPI(baseURL: Config.wikipediaURL)) {
    self.constructor = constructor
    self.constructorAPI = constructorAPI
    self.wikipediaApi = wikipediaApi
  }

  @State var constructorCardViewModel: ConstructorCardViewModel?

  func body(content: Content) -> some View {
    content
      .contentShape(Rectangle())
      .onTapGesture {
        constructorCardViewModel = ConstructorCardViewModel(constructor: constructor,
                                                  wikipediaApi: wikipediaApi,
                                                  apiConstructor: constructorAPI)
      }
      .fullScreenCover(isPresented: Binding<Bool>.constant(constructorCardViewModel != nil)) {
        CustomSheet(content: {
          if let constructorCardViewModel = constructorCardViewModel {
            ConstructorCardView(viewModel: constructorCardViewModel)
          }
        }, dismiss: {
          constructorCardViewModel = nil
        })
      }
  }
}

#Preview {
  Text("tap me")
    .modifier(ConstructorCardDisplayer(constructor: ConstructorModel.stub))
}
