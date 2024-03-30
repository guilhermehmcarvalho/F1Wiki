//
//  ContentViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {

  private var driverApi = APIDrivers(baseURL: Config.baseURL)
  @Published var status: FetchStatus = .ready
  var cancellable : AnyCancellable?

  func fetch() {
    do { 
      try cancellable = driverApi.listOfAllDrivers()
        .handleEvents(receiveSubscription: { [weak self] _ in
          self?.status = .ongoing
        }, receiveCompletion: { [weak self] completion in
          switch completion {
          case .finished:
            self?.status = .finished
          case .failure:
            self?.status = .ready
          }
        }, receiveCancel: { [weak self] in
          self?.status = .ready
        })
        .sink { error in
          print(error)
        } receiveValue: { drivers in
          print(drivers)
        }
    } catch let e {
      print(e)
    }

  }
}

enum FetchStatus {
  case ongoing, finished, ready
}

extension Publisher {
  func observeFetchStatus<S: Subject>(with fetchStatusSubject: S) -> Publishers.HandleEvents<Self> where S.Output == FetchStatus, S.Failure == Never {
    return handleEvents(receiveSubscription: { _ in
      // When fetching:
      fetchStatusSubject.send(.ongoing)
    }, receiveCompletion: { completion in
      switch completion {
      case .finished:
        // When finish successfully:
        fetchStatusSubject.send(.finished)
      case .failure:
        // When finish with error:
        fetchStatusSubject.send(.ready)
      }
    }, receiveCancel: {
      // When being cancelled:
      fetchStatusSubject.send(.ready)
    })
  }
}
