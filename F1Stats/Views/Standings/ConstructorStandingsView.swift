//
//  ConstructorStandingsView.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 14/04/2024.
//

import SwiftUI
import Combine

struct ConstructorStandingsView: View {

  @ObservedObject var viewModel: ConstructorStandingsViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ConstructorStandingsView(viewModel: ConstructorStandingsViewModel(apiSeasons: APISeasonsStub()))
}
