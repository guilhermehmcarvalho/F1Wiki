//
//  WikipediaSummaryModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 03/04/2024.
//

import Foundation

struct WikipediaSummaryModel: Decodable {
    let type: String
    let title: String
    let displaytitle: String
    let namespace: Namespace
    let wikibaseItem: String
    let titles: Titles
    let pageid: Int
    let thumbnail: Originalimage?
    let originalimage: Originalimage?
    let lang: String
    let dir: String
    let revision: String
    let tid: String
    let description: String?
    let descriptionSource: String?
    let contentUrls: ContentUrls
    let extract: String
    let extractHTML: String?
}

// MARK: - ContentUrls
struct ContentUrls: Codable {
    let desktop: Desktop
    let mobile: Desktop
}

// MARK: - Desktop
struct Desktop: Codable {
    let page: String
    let revisions: String
    let edit: String
    let talk: String
}

// MARK: - Namespace
struct Namespace: Codable {
    let id: Int
    let text: String
}

// MARK: - Originalimage
struct Originalimage: Codable {
    let source: String
    let width: Int
    let height: Int
}

// MARK: - Titles
struct Titles: Codable {
    let canonical: String
    let normalized: String
    let display: String
}
