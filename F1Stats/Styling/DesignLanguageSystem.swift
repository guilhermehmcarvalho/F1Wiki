//
//  DesignLanguageSystem.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 02/04/2024.
//

import Foundation
import SwiftUI

enum TypographyStyle {
  case small(color: Color = .F1Stats.appWhite)
  case body(color: Color = .F1Stats.appWhite)
  case heading(color: Color = .F1Stats.appWhite)
  case subHeader(color: Color = .F1Stats.appWhite)

  public var size: CGFloat {
    switch self {
    case .small: return 15
    case .body: return 17
    case .heading: return 22
    case .subHeader: return 20
    }
  }

  public var weight: Font.Weight {
    switch self {
    case .small, .body: return .regular
    case .heading: return .bold
    case .subHeader: return .medium
    }
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
       case .small(let color), .body(let color), .heading(let color),.subHeader(let color):
              return self.modifier(BaseTypography(type: type, color: color))
      }
   }
}

extension Font {
     public static func dlsFont(size: CGFloat, weight: Font.Weight =  .regular) -> Font {
       let fontName: String = {
         switch (weight) {
         case .bold: "NunitoSans-12ptExtraLight_Bold"
         case .regular: "NunitoSans-12ptExtraLight_Regular"
         case .light: "NunitoSans-12ptExtraLight_Light"
         case .medium: "NunitoSans-12ptExtraLight_Medium"
         case .semibold: "NunitoSans-12ptExtraLight_SemiBold"
         case .black: "NunitoSans-12ptExtraLight_Black"
         case .heavy: "NunitoSans-12ptExtraLight_ExtraBold"
         default: "NunitoSans-12ptExtraLight_Regular"
         }
       }()
     return Font.custom(fontName, size: size)
   }
}

extension UIFont {
  public static func dlsFont(size: CGFloat, weight: Font.Weight =  .regular) -> UIFont {
    let fontName: String = {
      switch (weight) {
      case .bold: "NunitoSans-12ptExtraLight_Bold"
      case .regular: "NunitoSans-12ptExtraLight_Regular"
      case .light: "NunitoSans-12ptExtraLight_Light"
      case .medium: "NunitoSans-12ptExtraLight_Medium"
      case .semibold: "NunitoSans-12ptExtraLight_SemiBold"
      case .black: "NunitoSans-12ptExtraLight_Black"
      case .heavy: "NunitoSans-12ptExtraLight_ExtraBold"
      default: "NunitoSans-12ptExtraLight_Regular"
      }
    }()
    return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
  }
}

