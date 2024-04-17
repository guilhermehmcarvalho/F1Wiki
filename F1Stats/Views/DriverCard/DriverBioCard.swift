//
//  DriverBioCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI

struct DriverBioCard: View {

  let bio: String

  var body: some View {
    VStack {
      CardStyling.makeCardTitle("BIO")
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
      VStack {
        Text(bio)
          .fixedSize(horizontal: false, vertical: true)
          .typography(type: .body(color: .F1Stats.appDark))
          .multilineTextAlignment(.center)

      }
      .padding(16)
    }
    .cardStyling()
  }
}


#Preview {
  DriverBioCard(bio: "asdasdasd")
}
