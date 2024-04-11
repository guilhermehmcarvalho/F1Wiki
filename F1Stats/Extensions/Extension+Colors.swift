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
    static let primary = Color.fromRGB(red: 179, green: 19, blue: 18)
    static let systemDark = Color.fromRGB(red: 33, green: 50, blue: 94)
    static let systemGreen = Color.green
    static let systemDarkSecondary = Color.fromRGB(red: 62, green: 73, blue: 122)
    static let systemLight = Color.fromRGB(red: 240, green: 240, blue: 240)
    static let systemWhite = Color.white
    static let systemYellow = Color.fromRGB(red: 255, green: 235, blue: 135)
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
