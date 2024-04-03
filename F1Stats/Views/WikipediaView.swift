//
//  WikipediaView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct WikipediaView: View {
  @ObservedObject var wikipediaViewModel: WikipediaViewModel

  var body: some View {
    return VStack {
      if let thumbURL = wikipediaViewModel.thumbURL, let imageURL = URL(string: thumbURL) {
        CachedAsyncImage(url: imageURL)
      }
      Text(wikipediaViewModel.title)
        .typography(type: .heading())
      Text(wikipediaViewModel.summary)
        .typography(type: .body())
    }
    .background(Color.red)
  }
}

#Preview {
  WikipediaView(wikipediaViewModel: WikipediaViewModel.stub)
}
