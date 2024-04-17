//
//  SplashScreen.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 17/04/2024.
//

import SwiftUI

struct SplashScreen: View {

  @Binding var animationComplete: Bool
  @State private var offset = CGSize(width: -200.0, height: 0)

  var body: some View {
    ZStack {
      Color.F1Stats.appDark.ignoresSafeArea()

      VStack {
        Image("TrimmedLogo")
          .resizable()
          .scaledToFit()
          .padding(.all(64))
      }
      .cardStyling()
      .padding(64)
      .offset(offset)
      .onAppear {
        withAnimation(.bouncy(duration: 0.5)) {
          self.offset = .zero
        }

        withAnimation(.easeIn(duration: 0.5).delay(1)) {
          self.offset = CGSize(width: 3000.0, height: 0)
        }
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
        withAnimation {
          self.animationComplete = true
        }
      }
    }
  }
}

#Preview {
    struct Preview: View {
      @State var animationComplete: Bool = false
        var body: some View {
            SplashScreen(animationComplete: $animationComplete)
        }
    }

    return Preview()
}
