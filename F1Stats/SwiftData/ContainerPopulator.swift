//
//  ContainerPopulator.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 23/05/2024.
//

import Foundation
import SwiftData

#if DEBUG
class ContainerPopulator {

	var modelContext: ModelContext

	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}

	internal func populateDB() {
		populateDrivers()
	}

	private func populateDrivers() {
		// Load and decode the JSON.
		 guard let url = Bundle.main.url(forResource: "drivers", withExtension: "json") else {
			 fatalError("Failed to find drivers.json")
		 }

		populateContainer(type: Driver.self, url: url)
	}

	private func populateContainer<T: PersistentModel>(type: T.Type, url: URL) where T: Decodable {
		do {
			// Check we haven't already added our data.
			let descriptor = FetchDescriptor<T>()
			let existingItems = try modelContext.fetchCount(descriptor)
			guard existingItems == 0 else { return }

			let data = try Data(contentsOf: url)
			let items = try JSONDecoder().decode([T].self, from: data)

			// Add all our data to the context.
			for item in items {
				modelContext.insert(item)
			}
		} catch let error  {
			print("Failed to pre-seed database.", error)
		}
	}
}
#endif
