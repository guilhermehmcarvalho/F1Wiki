//
//  ConstructorStandingsCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import Foundation

import SwiftUI

struct ConstructorStandingsCard: View {

  let standingLists: [StandingsList]

  var body: some View {
      VStack {
        CardStyling.makeCardTitle("Standings")
          .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))

        VStack(alignment: .leading) {
          HStack(alignment: .firstTextBaseline) {
            Text("Position")
              .typography(type: .body(color: .F1Stats.appDark))
              .frame(width: 70)
            Text("Wins")
              .typography(type: .body(color: .F1Stats.appDark))
              .frame(width: 70)
            Text("Points")
              .typography(type: .body(color: .F1Stats.appDark))
              .frame(width: 70)
            Text("Season")
              .frame(width: 70)
              .typography(type: .body(color: .F1Stats.appDark))

          }
          .padding(.horizontal(8))

          ForEach(standingLists, id: \.season) { season in
            if let standing = season.constructorStanding?.first {
              HStack {
                Text(standing.position)
                  .typography(type: .body(color: .F1Stats.appDark))
                  .frame(width: 70)
                Text(standing.wins)
                  .typography(type: .body(color: .F1Stats.appDark))
                  .frame(width: 70)
                Text(standing.points)
                  .typography(type: .body(color: .F1Stats.appDark))
                  .frame(width: 70)
                Text(season.season)
                  .frame(width: 70)
                  .typography(type: .body(color: .F1Stats.appDark))

              }
              .padding(.horizontal(8))
              .padding(.vertical(2))
            }
          }
        }
        .padding(16)
      }
      .cardStyling()
  }
}
