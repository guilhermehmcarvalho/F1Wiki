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

  var imageTransaction: Transaction = Transaction(
    animation: .spring(
      response: 0.5,
        dampingFraction: 0.65,
        blendDuration: 0.025)
)

  init(viewModel: WikipediaViewModel, imageTransaction: Transaction? = nil) {
    self.viewModel = viewModel
    if let imageTransaction = imageTransaction {
      self.imageTransaction = imageTransaction
    }
  }

  var body: some View {
    VStack {
      if viewModel.fetchStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.appWhite)
      }
      else if let summaryModel = viewModel.summaryModel {
        VStack(spacing: 0) {
          if let thumbURL = summaryModel.thumbnail?.source, let imageURL = URL(string: thumbURL) {
            AsyncImage(
                    url: imageURL,
                    transaction: imageTransaction
                ){ phase in
                    switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .transition(.scale)

                        case .failure(_):
                            Image(systemName:  "ant.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 128)
                                .foregroundColor(.teal)
                                .opacity(0.6)

                        default:
                            ProgressView()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
          }
          Text(summaryModel.title)
            .typography(type: .heading())
            .textCase(.uppercase)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 32, leading: 8, bottom: 24, trailing: 8))
          Text(summaryModel.extract)
            .multilineTextAlignment(.center)
            .typography(type: .body())
            .padding(.horizontal(16))
        }
      }
    }
    .onAppear(perform: viewModel.fetchSummary)
  }


}
