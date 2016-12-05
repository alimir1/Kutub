//
//  BookStateController.swift
//  Kutub
//
//  Created by Ali Mir on 12/2/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
}

class StateController {
    private(set) var books = [Book]()
    private(set) var authors = [Author]()
    private(set) var categories = [BookCategory]()
    private(set) var publishers = [Publisher]()
    private(set) var tags = [Tag]()
    private(set) var featuredCategories = [FeaturedCategory]()
    
    func addItem(item: AnyObject) {
        switch item {
        case is Book:
            books.append(item as! Book)
        case is Author:
            authors.append(item as! Author)
        case is BookCategory:
            categories.append(item as! BookCategory)
        case is Publisher:
            publishers.append(item as! Publisher)
        case is Tag:
            tags.append(item as! Tag)
        case is FeaturedCategory:
            featuredCategories.append(item as! FeaturedCategory)
        default:
            print("Not a valid item!")
        }
    }
}
