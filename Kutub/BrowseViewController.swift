//
//  BrowseViewController.swift
//  Kutub
//
//  Created by Ali Mir on 12/5/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import Firebase

class BrowseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var featuredBooksCollection = [FeaturedBooks]()
    var storedOffsets = [Int: CGFloat]()
    var featuredCollectionCache = [String : Int]()
    var databaseReference: FIRDatabaseReference!
    var handleValueForFeaturedBooksCategories: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseReference = FIRDatabase.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromFirebase()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        databaseReference.removeObserver(withHandle: handleValueForFeaturedBooksCategories)
    }
    
    func getDataFromFirebase() {
        handleValueForFeaturedBooksCategories = databaseReference.child("FeaturedBooksCategories").observe(.value, with: {
            (featuredBooks) in
            for (featuredCategoryIndex, featuredBook) in ((featuredBooks.children.allObjects as! [FIRDataSnapshot])).enumerated() {
                let featuredTitle = featuredBook.key
                guard (self.featuredCollectionCache[featuredTitle] == nil) else {
                    return
                }
                self.featuredCollectionCache[featuredTitle] = featuredCategoryIndex
                if !featuredBook.hasChildren() {
                    // Example: [Ayatullah Murtadha Mutahhari : "Authors"]...
                    let featuredReference = featuredBook.value as! String
                    self.featuredBooksCollection.append(FeaturedBooks(name: featuredBook.key, books: [BrowsingBook]()))
                    self.databaseReference.child("Kutub/\(featuredReference)/\(featuredTitle)/Books").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: {
                        (bookUniqueKeys) in
                        self.downloadBrowsingBooks(bookUniqueKeys: bookUniqueKeys, index: featuredCategoryIndex)
                    })
                } else {
                    // Example: [Custom Category : [book1, book2, book3 ...]]
                    
                }
            }
        })
    }
    
    func downloadBrowsingBooks(bookUniqueKeys: FIRDataSnapshot, index: Int) {
        for uniqueBookKey in bookUniqueKeys.children.allObjects as! [FIRDataSnapshot] {
            databaseReference.child("Kutub/Books/\(uniqueBookKey.key)").observeSingleEvent(of: .value, with: {
                (snapshot) in
                let browsingBookValues = snapshot.value as! [String : AnyObject]
                let browsingBook = self.createBrowsingBookObject(data: browsingBookValues, uniqueKey: uniqueBookKey.key)
                self.featuredBooksCollection[index].books.append(browsingBook)
                self.tableView.reloadData()
            })
        }
    }
    
    func createBrowsingBookObject(data: [String : AnyObject], uniqueKey: String) -> BrowsingBook {
        let title = data["Title"] as! String
        let bookDescription = data["Description"] as? String
        let miscellaneousInformation = data["Miscellaneous Information"] as? String
        let authors = parseStringArrays(data: data, string: "Authors")
        let publishers = parseStringArrays(data: data, string: "Publishers")
        let tags = parseStringArrays(data: data, string: "Tags")
        let translators = parseStringArrays(data: data, string: "Translators")
        let featuredCategories = parseStringArrays(data: data, string: "Featured Categories")
        
        return BrowsingBook(title: title, bookDescription: bookDescription, miscellaneousInformation: miscellaneousInformation, uniqueKey: uniqueKey, authors: authors, publishers: publishers, tags: tags, translators: translators, featuredCategories: featuredCategories)
    }
    
    func parseStringArrays(data: [String : AnyObject], string: String) -> [String]? {
        guard let element = data[string] as? [String : Bool] else { return nil }
        var array = [String]()
        for (key, _) in element {
            array.append(key)
        }
        return array
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredBooksCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: "browseCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
//        browseCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        browseCell.configureCell(title: featuredBooksCollection[indexPath.row].name)
        browseCell.books = featuredBooksCollection[indexPath.row].books
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
//        storedOffsets[indexPath.row] = browseCell.collectionViewOffset
    }
}



