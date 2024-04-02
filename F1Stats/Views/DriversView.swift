//
//  DriversView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 01/04/2024.
//

import SwiftUI

struct DriversView: View {
  @ObservedObject var driversViewModel: DriversViewModel

  var body: some View {
    List(driversViewModel.driverList) { driver in
      HStack {
        Text(driver.familyName)
          .textCase(.uppercase)
          .typography(type: .heading6())
        Text(driver.givenName)
          .typography(type: .small())
      }
      .onAppear() {
        driversViewModel.onItemDisplayed(currentItem: driver)
      }
    }
    .onAppear(perform: {
      driversViewModel.fetchDrivers()
    })
  }

}

#Preview {
  DriversView(driversViewModel: DriversViewModel(driverApi: MockAPIDrivers()))
}

enum TypographyStyle {
  case small(color: Color = .black)
  case body(color: Color = .black)
  case heading6(color: Color = .black)

  public var size: CGFloat {
    switch self {
    case .small: return 15
    case .body: return 17
    case .heading6: return 22
    }
  }

  public var weight: Font.Weight {
    switch self {
    case .small, .body: return .regular
    case .heading6: return .bold
    }
  }
}

extension Font {
     public static func dlsFont(size: CGFloat, weight: Font.Weight =  .regular) -> Font {
     var fontName = "NunitoSans_10pt-Regular"
     if weight == .bold {
          fontName = "NunitoSans_10pt-Bold"
      }
     return Font.custom(fontName, size: size)
   }
}

struct BaseTypography: ViewModifier {
  let type: TypographyStyle //our enum
  let color: Color

  init(type: TypographyStyle, color: Color = .black) {
    self.type = type
    self.color = color
  }

  func body(content: Content) -> some View {
    content
      .font(.dlsFont(size: type.size, weight: type.weight))
      .foregroundColor(color)
  }
}

extension View {
   func typography(type: TypographyStyle) -> some View {
       switch type {
          case .small(let color), .body(let color), .heading6(let color):
              return self.modifier(BaseTypography(type: type, color: color))
      }
   }
}
