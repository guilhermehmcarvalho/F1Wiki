//
//  ContainerFactory.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 23/05/2024.
//

import Foundation
import SwiftData

class ContainerFactory {

	let dbURL: URL

	init(dbURL: URL) {
		self.dbURL = dbURL
	}

	private let schema: Schema = Schema([Driver.self])
	private var configuration: ModelConfiguration {
		ModelConfiguration(schema: schema, url: dbURL)
	}

	private let configurations: [ModelConfiguration] =	[ModelConfiguration(for: Driver.self)]

	func makeContainer() -> ModelContainer {
		do {
			return try ModelContainer(for: schema, configurations: configuration)
		} catch {
			fatalError("Failed to configure SwiftData container.")
		}
	}

	func openLocalContainer(fileName: String) -> ModelContainer {
		do {
			guard let storeURL = Bundle.main.url(forResource: fileName, withExtension: "db") else {
				fatalError("Failed to find users.store")
			}

			let config = ModelConfiguration(url: storeURL)
			return try ModelContainer(for: schema, configurations: config)
		} catch {
			fatalError("Failed to configure SwiftData container.")
		}
	}
}
