//
//  Toast.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 19/04/2024.
//

import Foundation

struct Toast: Equatable {
  static func == (lhs: Toast, rhs: Toast) -> Bool {
    lhs.style == rhs.style && lhs.message == rhs.message
  }
  
  var style: ToastStyle
  var message: String
  var duration: Double?
  var width: Double = .infinity
  var onTap: (() -> Void)? = nil
}
