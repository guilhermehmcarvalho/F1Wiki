//
//  CountdownVIew.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 18/04/2024.
//

import SwiftUI

struct CountdownView: View {

  @ObservedObject var viewModel: CountdownViewModel

  var body: some View {
    HStack {
      // Days
      VStack {
        if let days = viewModel.days {
          Text(days)
            .typography(type: .body())
          Text("Days")
            .typography(type: .extraSmall())
        }
      }
      .frame(width: 60)

      Spacer()

      // Hours
      VStack {
        if let hours = viewModel.hours {
          Text(hours)
            .typography(type: .body())
          Text("Hours")
            .typography(type: .extraSmall())
        }
      }
      .frame(width: 60)

      Spacer()

      // Minutes
      VStack {
        if let minutes = viewModel.minutes {
          Text(minutes)
            .typography(type: .body())
          Text("Minutes")
            .typography(type: .extraSmall())
        }
      }
      .frame(width: 60)
    }
    .fixedSize(horizontal: true, vertical: true)
    .onAppear(perform: viewModel.runCountdown)
  }
}

#Preview {
  CountdownView(viewModel:
                  CountdownViewModel(
                    targetDate: Calendar.current.date(byAdding: .day, value: 10, to: Date.now)!)
                )
}
