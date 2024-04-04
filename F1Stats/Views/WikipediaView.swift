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
            AsyncImage(
                    url: imageURL,
                    transaction: Transaction(
                        animation: .spring(
                          response: 0.5,
                            dampingFraction: 0.65,
                            blendDuration: 0.025)
                    )
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
          }
          Text(summaryModel.title)
            .typography(type: .heading())
            .textCase(.uppercase)
            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            .padding(EdgeInsets(top: 32, leading: 8, bottom: 24, trailing: 8))
          Text(summaryModel.extract)
            .multilineTextAlignment(.center)
            .typography(type: .body())
            .padding(.horizontal(16))
        }
      }
    }
  }
}
