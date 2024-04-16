//
//  DesignLanguageSystem.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 02/04/2024.
//

import Foundation
import SwiftUI

enum TypographyStyle {
  case small(color: Color = .F1Stats.appDark)
  case heavyBody(color: Color = .F1Stats.appDark)
  case body(color: Color = .F1Stats.appDark)
  case heading(color: Color = .F1Stats.appDark)
  case subHeader(color: Color = .F1Stats.appDark)

  public var size: CGFloat {
    switch self {
    case .small: return 15
    case .body: return 17
    case .heavyBody: return 17
    case .heading: return 22
    case .subHeader: return 20
    }
  }

  public var weight: Font.Weight {
    switch self {
    case .small, .body: return .regular
    case .heading, .heavyBody: return .bold
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
       case .small(let color), 
           .body(let color),
           .heavyBody(let color),
           .heading(let color),
           .subHeader(let color):
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

extension View {
  func clickableUnderline(color: Color = Color.F1Stats.appDark,
                          opacity: CGFloat = 0.2,
                          height: CGFloat = 1,
                          offset: CGSize = CGSize(width: 0, height: 10)) -> some View {
    return self.background(
      color
        .opacity(opacity)
        .frame(height: height) // underline's height
        .offset(offset)
    )
  }
}
