//
//  ComicModel.swift
//  Marv-Lous
//
//  Created by Erik Egers on 2022/03/18.
//

import Foundation 

// MARK: - ComicDataWrapper
struct ComicDataWrapper: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: ComicDataContainer
    let etag: String
}

// MARK: - ComicDataContainer
struct ComicDataContainer: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Comic]
}

// MARK: - Comic
struct Comic: Codable {
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Double?
    let variantDescription: String?
    let description: String?
    let modified: String?
    let isbn: String?
    let upc: String?
    let diamondCode: String?
    let ean: String?
    let issn: String?
    let format: String?
    let pageCount: Int?
    let textObjects: [TextObject]?
    let resourceURI: String?
    let urls: [Url]?
    let series: SeriesSummary?
    let variants: [ComicSummary]?
    let collections: [ComicSummary]?
    let collectedIssues: [ComicSummary]?
    let dates: [ComicDate]?
    let prices: [ComicPrice]?
    let thumbnail: Image?
    let images: [Image]?
    let creators: CreatorList?
    let characters: CharacterList?
    let stories: StoryList?
    let events: EventList?
}

// MARK: - TextObject
struct TextObject: Codable {
    let type: String?
    let language: String?
    let text: String?
}

// MARK: - Url
struct Url: Codable {
    let type: String?
    let url: String?
}

// MARK: - SeriesSummary
struct SeriesSummary: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - ComicSummary
struct ComicSummary: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - ComicDate
struct ComicDate: Codable {
    let type: String?
    let date: String?
}

// MARK: - ComicPrice
struct ComicPrice: Codable {
    let type: String?
    let price: Float?
}

// MARK: - Image
struct Image: Codable {
    let path: String?
    let `extension`: String?
}

// MARK: - CreatorList
struct CreatorList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [CreatorSummary]?
}

// MARK: - CreatorSummary
struct CreatorSummary: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

// MARK: - CharacterList
struct CharacterList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [CharacterSummary]?
}

// MARK: - CharacterSummary
struct CharacterSummary: Codable {
    let resourceURI: String?
    let name: String?
    let role: String?
}

// MARK: - StoryList
struct StoryList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StorySummary]?
}

// MARK: - StorySummary
struct StorySummary: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: - EventList
struct EventList: Codable {
    let  available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
}

// MARK: - EventSummary
struct EventSummary: Codable {
    let resourceURI: String?
    let name: String?
}
