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
  @ObservedObject var viewModel: WikipediaViewModel

  var body: some View {
    VStack {
      if viewModel.fetchStatus == .ongoing {
        ProgressView()
          .padding(.all(16))
          .tint(.F1Stats.systemLight)
      }
      else if let summaryModel = viewModel.summaryModel {
        VStack(spacing: 0) {
          if let thumbURL = summaryModel.thumbnail?.source, let imageURL = URL(string: thumbURL) {
            withAnimation(.default) {
              CachedAsyncImage(url: imageURL)
                .transition(.opacity.animation(.default))
            }
          }
          Text(summaryModel.title)
            .typography(type: .heading())
            .textCase(.uppercase)
            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            .padding(EdgeInsets(top: 32, leading: 8, bottom: 24, trailing: 8))
          Text(summaryModel.extract)
            .multilineTextAlignment(.center)
            .typography(type: .body())
        }
      }
    }
  }
}
