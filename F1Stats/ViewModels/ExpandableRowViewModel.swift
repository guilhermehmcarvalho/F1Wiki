//
//  ExpandableRowViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation
import SwiftUI

protocol ExpandableRowView : View {
  var expandedView: AnyView { get }
  var viewModel: any ExpandableRowViewModel { get set }
}

protocol ExpandableRowViewModel : ObservableObject {
  func onTap(isExpanded: Bool) -> ()
}
