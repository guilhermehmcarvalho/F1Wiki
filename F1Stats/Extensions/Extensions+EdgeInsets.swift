//
//  Extensions+EdgeInsets.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 02/04/2024.
//

import Foundation
import SwiftUI

extension EdgeInsets {
  static func all(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: value, leading: value, bottom: value, trailing: value)
  }
}

