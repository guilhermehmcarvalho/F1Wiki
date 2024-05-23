//
//  ContainerFactory.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 23/05/2024.
//

import Foundation
import SwiftData

class ContainerFactory {
	static func makeContainer() -> ModelContainer {
		do {
			let config1 = ModelConfiguration(for: Driver.self)
			return try ModelContainer(for: Driver.self, configurations: config1)
		} catch {
			fatalError("Failed to configure SwiftData container.")
		}
	}
}
