//
//  Book.swift
//  Kutub
//
//  Created by Ali Mir on 12/2/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

class Book {
    let authors: [Author]?
    let categories: [BookCategory]?
    let publishers: [Publisher]?
    let tags: [Tag]?
    let title: String
    let description: String?
    let featuredCategories: [FeaturedCategory]?
    let miscellaneousInformation: String?
    let uniqueKey: String
    
    init(uniqueKey: String, authors: [Author]? = nil, categories: [BookCategory]? = nil, publishers: [Publisher]? = nil, tags: [Tag]? = nil, title: String, description: String? = nil, featuredCategories: [FeaturedCategory]? = nil, miscellaneousInformation: String? = nil) {
        self.uniqueKey = uniqueKey
        self.authors = authors
        self.categories = categories
        self.publishers = publishers
        self.tags = tags
        self.title = title
        self.description = description
        self.featuredCategories = featuredCategories
        self.miscellaneousInformation = miscellaneousInformation
    }
}

struct Info {
    let name: String
    let books: [Book]? = nil
}

struct Author {
    let info: Info
}

struct BookCategory {
    let info: Info
}

struct Publisher {
    let info: Info
}

struct Tag {
    let info: Info
}

struct Translator {
    let info: Info
}

struct FeaturedCategory {
    let info: Info
}
