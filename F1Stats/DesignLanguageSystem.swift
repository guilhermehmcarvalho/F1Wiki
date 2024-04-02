//
//  DesignLanguageSystem.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 02/04/2024.
//

import Foundation
import SwiftUI

enum TypographyStyle {
  case small(color: Color = .black)
  case body(color: Color = .black)
  case heading(color: Color = .black)

  public var size: CGFloat {
    switch self {
    case .small: return 15
    case .body: return 17
    case .heading: return 22
    }
  }

  public var weight: Font.Weight {
    switch self {
    case .small, .body: return .regular
    case .heading: return .bold
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
          case .small(let color), .body(let color), .heading(let color):
              return self.modifier(BaseTypography(type: type, color: color))
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

