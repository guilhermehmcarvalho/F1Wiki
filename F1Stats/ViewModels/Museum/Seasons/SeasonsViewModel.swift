//
//  SeasonsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 06/04/2024.
//

import Foundation
import Combine

class SeasonsViewModel: ObservableObject {
  
  private var apiSeasons: APISeasonsProtocol
  private let wikipediaAPI: WikipediaAPIProtocol
  
  private(set) var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  
  @Published var fetchStatus: FetchStatus = .ready
  @Published var seasonsList: [SeasonModel] = []
  
  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
  private var totalSeasons = 0;
  private var paginationThresholdId: String?
  
  init(apiSeasons: APISeasonsProtocol, wikipediaAPI: WikipediaAPIProtocol) {
    self.apiSeasons = apiSeasons
    self.wikipediaAPI = wikipediaAPI
    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
  }
  
  func fetchSeasons() {
    cancellable = apiSeasons.listOfAllSeasons(limit: itemsPerPage, offset: offset)
      .observeFetchStatus(with: fetchStatusSubject)
      .receive(on: DispatchQueue.main)
      .sink { status in
        switch status {
        case .finished: break
        case .failure(let error):
          print(error)
        }
      } receiveValue: { [weak self] response in
        self?.seasonsList.append(contentsOf: response.table.seasons)
        self?.offset += response.table.seasons.count
        self?.totalSeasons = response.total
        if let self = self {
          var thresholdIndex = self.seasonsList.index(self.seasonsList.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = seasonsList[thresholdIndex].season
        }
      }
  }

  func onAppear() {
    if seasonsList.isEmpty {
      fetchSeasons()
    }
  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: SeasonModel){
    if item.season == paginationThresholdId, seasonsList.count < totalSeasons {
      fetchSeasons()
    }
  }
  
  func viewModel(for seasons: SeasonModel) -> SeasonCardViewModel {
    SeasonCardViewModel(season: seasons,
                       wikipediaApi: wikipediaAPI,
                       apiSeason: apiSeasons)
  }
}
