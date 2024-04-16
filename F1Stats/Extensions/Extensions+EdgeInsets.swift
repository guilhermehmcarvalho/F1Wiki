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

  static func horizontal(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: 0, leading: value, bottom: 0, trailing: value)
  }

  static func vertical(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: value, leading: 0, bottom: value, trailing: 0)
  }

  static func top(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: value, leading: 0, bottom: 0, trailing: 0)
  }

  static func bottom(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: 0, leading: 0, bottom: value, trailing: 0)
  }

  static func leading(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: 0, leading: value, bottom: 0, trailing: 0)
  }

  static func trailing(_ value: CGFloat) -> EdgeInsets {
    return self.init(top: 0, leading: 0, bottom: 0, trailing: value)
  }
}

