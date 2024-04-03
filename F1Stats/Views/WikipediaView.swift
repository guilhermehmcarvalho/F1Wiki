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
    return VStack(spacing: 0) {
      if let thumbURL = wikipediaViewModel.thumbURL, let imageURL = URL(string: thumbURL) {
        CachedAsyncImage(url: imageURL)
      }
      Text(wikipediaViewModel.title)
        .typography(type: .heading())
        .textCase(.uppercase)
        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        .padding(EdgeInsets(top: 32, leading: 8, bottom: 24, trailing: 8))
      Text(wikipediaViewModel.summary)
        .multilineTextAlignment(.center)
        .typography(type: .body())
    }
  }
}

#Preview {
  WikipediaView(wikipediaViewModel: WikipediaViewModel.stub)
}
