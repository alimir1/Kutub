//
//  BookStateController.swift
//  Kutub
//
//  Created by Ali Mir on 12/2/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

class BooksStateController {
    private(set) var books = [BrowsingBook]()

    func addBook(book: BrowsingBook) {
        books.append(book)
    }
    
    static let shared = BooksStateController()
}
