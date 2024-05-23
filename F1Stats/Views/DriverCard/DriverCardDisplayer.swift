//
//  DriverCardDisplayer.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 15/04/2024.
//

import SwiftUI

// At the moment dependency injection in this view is not being enforced in this view
// as it would generate basically too much boilerplate, since this view can be called from
// almost the whole app
struct DriverCardDisplayer: ViewModifier {
  let driver: Driver
  let wikipediaApi: WikipediaAPIProtocol
  let driverApi: APIDriversProtocol

  init(driver: Driver,
       driverApi: APIDriversProtocol = APIDrivers(baseURL: Config.baseURL),
       wikipediaApi: WikipediaAPIProtocol = WikipediaAPI(baseURL: Config.wikipediaURL)) {
    self.driver = driver
    self.driverApi = driverApi
    self.wikipediaApi = wikipediaApi
  }

  @State var driverCardViewModel: DriverCardViewModel?

  func body(content: Content) -> some View {
    content
      .contentShape(Rectangle())
      .onTapGesture {
        driverCardViewModel = DriverCardViewModel(driver: driver,
                                                  wikipediaApi: wikipediaApi,
                                                  driverApi: driverApi)
      }
      .fullScreenCover(isPresented: Binding<Bool>.constant(driverCardViewModel != nil)) {
        CustomSheet(content: {
          if let driverCardViewModel = driverCardViewModel {
            DriverCardView(viewModel: driverCardViewModel)
          }
        }, dismiss: {
          driverCardViewModel = nil
        })
      }
  }
}

#Preview {
  Text("tap me")
    .modifier(DriverCardDisplayer(driver: Driver.stub))

}
