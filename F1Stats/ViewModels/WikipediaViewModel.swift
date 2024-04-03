//
//  WikipediaViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI

class WikipediaViewModel: ObservableObject {
  let title: String
  let summary: String
  var thumbURL: String?

  init(title: String, summary: String, thumbURL: String?) {
    self.title = title
    self.summary = summary
    self.thumbURL = thumbURL
  }

  init(fromSummary summary: WikipediaSummaryModel) {
    self.title = summary.title
    self.summary = summary.extract
    self.thumbURL = summary.thumbnail?.source
  }
}

extension WikipediaViewModel {
  static var stub = WikipediaViewModel(title: "Wikipedia article",
                                       summary: "Summary of wikipedia article",
                                       thumbURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Ayrton_Senna_8_%28cropped%29.jpg")
}
