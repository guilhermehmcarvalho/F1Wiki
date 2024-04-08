//
//  WikiCommonsMedia.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 08/04/2024.
//

import Foundation

struct WikiCommonsMedia: Codable {
    let revision: String
    let tid: String
    let items: [MediaItem]

    enum CodingKeys: String, CodingKey {
        case revision = "revision"
        case tid = "tid"
        case items = "items"
    }
}

// MARK: - Item
struct MediaItem: Codable {
    let title: String
    let leadImage: Bool
    let sectionID: Int?
    let type: TypeEnum
    let showInGallery: Bool
    let srcset: [Srcset]
    let caption: Caption?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case leadImage = "leadImage"
        case sectionID = "section_id"
        case type = "type"
        case showInGallery = "showInGallery"
        case srcset = "srcset"
        case caption = "caption"
    }
}

// MARK: - Caption
struct Caption: Codable {
    let html: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case html = "html"
        case text = "text"
    }
}

// MARK: - Srcset
struct Srcset: Codable {
    let src: String
    let scale: Scale

    enum CodingKeys: String, CodingKey {
        case src = "src"
        case scale = "scale"
    }
}

enum Scale: String, Codable {
    case the15X = "1.5x"
    case the1X = "1x"
    case the2X = "2x"
}

enum TypeEnum: String, Codable {
    case image = "image"
}
