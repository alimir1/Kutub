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
    var bookDescription: String {get}
    var miscellaneousInformation: String {get}
    var uniqueKey: String {get}
}

struct BrowsingBook: BookMetadata {
    let title: String
    let bookDescription: String
    let miscellaneousInformation: String
    let uniqueKey: String
    let authors: [Info]
    let publishers: [Info]
    let tags: [Info]
    let translators: [Info]
    let featuredCategories: [Info]
}

struct Info {
    let name: String
    let uniqueKey: String
}

class DownloadedBook: Object, BookMetadata {
    dynamic var title = ""
    dynamic var bookDescription = ""
    dynamic var miscellaneousInformation = ""
    dynamic var uniqueKey = ""
    dynamic var ebookPath = ""
    dynamic var authors = ""
    dynamic var translators = ""
    dynamic var publishers = ""
    dynamic var dateDownloaded = Date()
    
    override class func primaryKey() -> String? { return "uniqueKey" }
}
