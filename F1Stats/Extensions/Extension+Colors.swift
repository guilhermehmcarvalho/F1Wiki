//
//  extension+Colors.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI

public extension Color {
  struct F1Stats {
    static let primary = Color.fromRGB(red: 179, green: 19, blue: 18) //#b31312
    static let appDark = Color.fromRGB(red: 29, green: 53, blue: 75)
    static let appGreen = Color.fromRGB(red: 2, green: 113, blue: 72)
    static let appDarkSecondary = Color.fromRGB(red: 40, green: 70, blue: 99)
    static let appWhite = Color.fromRGB(red: 255, green: 252, blue: 241)
    static let appYellow = Color.fromRGB(red: 255, green: 235, blue: 150)
  }
}

public extension Color {
  static func fromRGB(red: Double, green: Double, blue: Double, opacity: Double = 255) -> Color {
    Color(red: red/255, green: green/255, blue: blue/255, opacity: opacity/255)
  }

  var asUIColor: UIColor {
    UIColor(self)
  }
}
