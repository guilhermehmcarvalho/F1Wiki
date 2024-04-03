//
//  ExpandableRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI

protocol ExpandableRowViewModel: ObservableObject {
  var mainView: AnyView { get }
  var expandedView: AnyView { get set }
  func onTap(isExpanded: Bool) -> ()
}
