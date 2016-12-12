//
//  BookListViewController.swift
//  Kutub
//
//  Created by Ali Mir on 12/9/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BookListViewController: UITableViewController {
    var booksList = [BrowsingBook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension BookListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let bookListCell = cell as? BookListCell else { return }
        let authors = booksList[indexPath.row].authors
        var newAuthorsName: String? = nil
        if let authors = authors {
            newAuthorsName = ""
            for author in authors {
                newAuthorsName! += ", \(author)"
            }
        }
        bookListCell.configureCell(bookTitle: booksList[indexPath.row].title, bookAuthor: newAuthorsName, bookImage: nil)
    }
}
