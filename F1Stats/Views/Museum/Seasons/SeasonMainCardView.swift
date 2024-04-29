//
//  SeasonMainCardView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 17/04/2024.
//

import SwiftUI

struct SeasonMainCardView: View {

  @ObservedObject var viewModel: WikipediaViewModel

  var body: some View {
    VStack {
      if viewModel.fetchStatus == .ongoing {
        ProgressView()
          .tint(.F1Stats.appWhite)
      } else if let summary = viewModel.summaryModel {
        mainCardView(summary: summary)
      }
    }
    .onAppear(perform: viewModel.fetchSummary)
  }

  func mainCardView(summary: WikipediaSummaryModel) -> some View {
    VStack {
      VStack {
        ZStack(alignment: .bottom) {
          if let imageString = summary.originalimage?.source, let urlImage = URL(string: imageString) {
            CachedAsyncImage(url: urlImage) {
              ProgressView()
                .tint(.F1Stats.primary)
                .padding(32)
            }
            .scaledToFill()
            .frame(maxHeight: 350)
            .clipped()
            .fixedSize(horizontal: false, vertical: true)
          }

          CardStyling.makeCardTitle(summary.title)
            .padding(.vertical(16))
        }

        Text(summary.extract)
          .padding(16)
          .typography(type: .body(color: .F1Stats.appDark))
          .multilineTextAlignment(.center)
          .fixedSize(horizontal: false, vertical: true)
      }
    }
    .cardStyling()
  }
}

#Preview {
    SeasonMainCardView(viewModel: WikipediaViewModel(url: "", wikipediaApi: WikipediaAPIStub()))
}
