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
      title("BIO")
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

  func title(_ title: String) -> some View {
    ZStack {
      Color.F1Stats.primary

      Text(title)
        .textCase(.uppercase)
        .typography(type: .heading(color: .F1Stats.appWhite))
        .padding(.all(4))
        .multilineTextAlignment(.center)
    }
    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
  }
}


#Preview {
  DriverBioCard(bio: "asdasdasd")
}
