//
//  ContainerPopulator.swift
//  F1Wiki
//
//  Created by Guilherme Carvalho on 23/05/2024.
//

import Foundation
import SwiftData
import CoreData

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
		 guard let url = Bundle.main.url(forResource: "drivers", withExtension: "json") else {
			 fatalError("Failed to find drivers.json")
		 }

		populateContainer(type: Driver.self, url: url)
	}

	private func populateContainer<T: PersistentModel>(type: T.Type, url: URL) where T: Decodable {
		do {
			let descriptor = FetchDescriptor<T>()
			let existingItems = try modelContext.fetchCount(descriptor)
			guard existingItems == 0 else { return }

			let data = try Data(contentsOf: url)
			let items = try JSONDecoder().decode([T].self, from: data)

			for item in items {
				modelContext.insert(item)
			}
		} catch let error  {
			print("Failed to pre-seed database.", error)
		}
	}

	func createDB(filePath: URL) {
		let container = NSPersistentContainer(name: "F1WikiContainer")
		let storeURL = URL.documentsDirectory.appending(path: "F1Wiki.store")

		if let description = container.persistentStoreDescriptions.first {
			// Delete all existing data.
			try? FileManager.default.removeItem(at: storeURL)

			// Make Core Data write to our new store URL.
			description.url = storeURL

			// Force WAL mode off.
			description.setValue("DELETE" as NSObject, forPragmaNamed: "journal_mode")
		}

		container.loadPersistentStores { description, error in
			do {
				// Add all your pre-fill data here.
//				for i in 1...10_000 {
//					let user = User(context: container.viewContext)
//					user.name = "User \(i)"
//					container.viewContext.insert(user)
//				}

				// Ensure all our changes are fully saved.
				try container.viewContext.save()

				// Adjust this to the actual location where you want the file to be saved.
				let destination = filePath
				try FileManager.default.copyItem(at: storeURL, to: destination)
			} catch {
				print("Failed to create data: \(error.localizedDescription)")
			}
		}
	}
}
#endif
