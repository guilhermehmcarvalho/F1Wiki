//
//  ContentViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 29/03/2024.
//

import Foundation
import Combine

class DriversViewModel: ObservableObject {
  
  private var driverApi: APIDriversProtocol
  @Published var status: FetchStatus = .ready
  @Published var driverList: [Driver] = []
  private var cancellable: AnyCancellable?
  private var page: Int = 0
  private let itemsPerPage = 30
  private var offset = 0
  private var totalDrivers = 0;
  private var paginationThreshold: String?

  init(driverApi: APIDriversProtocol) {
    self.driverApi = driverApi
  }
  
  func fetchDrivers() {
    cancellable = driverApi.listOfAllDrivers(limit: itemsPerPage, offset: offset)
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
      .receive(on: DispatchQueue.main)
      .sink { error in
        print(error)
      } receiveValue: { [weak self] response in
        guard let self = self else { return }
        self.driverList.append(contentsOf: response.table.drivers)
        self.offset += response.table.drivers.count
        self.totalDrivers = response.total
        let thresholdIndex = self.driverList.index(self.driverList.endIndex, offsetBy: -5)
        self.paginationThreshold = driverList[thresholdIndex].driverId
      }
  }
  
  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: Driver){
    if item.driverId == paginationThreshold, driverList.count < totalDrivers {
      fetchDrivers()
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
