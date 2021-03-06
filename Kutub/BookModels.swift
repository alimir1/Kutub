//
//  Book.swift
//  Kutub
//
//  Created by Ali Mir on 12/2/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation
import RealmSwift

protocol BookMetadata {
    var title: String {get}
    var bookDescription: String? {get}
    var miscellaneousInformation: String? {get}
    var uniqueKey: String {get}
}

enum BookInfos: String {
    case title, description
}

struct BrowsingBook: BookMetadata {
    let title: String
    let bookDescription: String?
    let miscellaneousInformation: String?
    let uniqueKey: String
    let authors: [String]?
    let publishers: [String]?
    let tags: [String]?
    let translators: [String]?
    let featuredCategories: [String]?
    
    init(title: String, bookDescription: String? = nil, miscellaneousInformation: String? = nil, uniqueKey: String, authors: [String]? = nil, publishers: [String]? = nil, tags: [String]? = nil, translators: [String]? = nil, featuredCategories: [String]? = nil) {
        self.title = title
        self.bookDescription = bookDescription
        self.miscellaneousInformation = miscellaneousInformation
        self.uniqueKey = uniqueKey
        self.authors = authors
        self.publishers = publishers
        self.tags = tags
        self.translators = translators
        self.featuredCategories = featuredCategories
    }
}
class DownloadedBook: Object, BookMetadata {
    dynamic var title: String = ""
    dynamic var bookDescription: String? = ""
    dynamic var miscellaneousInformation: String? = ""
    dynamic var uniqueKey = ""
    dynamic var ebookPath = ""
    dynamic var authors = ""
    dynamic var translators = ""
    dynamic var publishers = ""
    dynamic var dateDownloaded = Date()
    
    override class func primaryKey() -> String? { return "uniqueKey" }
}


enum FeaturedItemTypes {
    case reference, custom, spotlight
}

struct BookReference {
    let section: String
    let sectionName: String
}

struct CompleteCollection {
    let name: String
    let type: FeaturedItemTypes
    var reference: Reference?
    var custom: Custom?
    var spotlight: SpotLight?
    
    init(name: String, type: FeaturedItemTypes, reference: Reference? = nil, custom: Custom? = nil, spotlight: SpotLight? = nil) {
        self.name = name
        self.type = type
        self.custom = custom
        self.reference = reference
        self.spotlight = spotlight
    }
}

struct Reference {
    let reference: BookReference
    var books = [BrowsingBook]()
    init(reference: BookReference) {
        self.reference = reference
    }
}

struct Custom {
    var books = [BrowsingBook]()
}

struct SpotLight {
    var spotlights: [BookReference]
}
