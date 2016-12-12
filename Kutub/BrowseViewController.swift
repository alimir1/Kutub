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
    var featuredCollection = [Featured]()
    var storedOffsets = [Int: CGFloat]()
    var featuredCollectionCache = [String]()
    var databaseReference: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseReference = FIRDatabase.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromFirebase()
    }
    
    func getDataFromFirebase() {
        databaseReference.child("FeaturedBooksCategories").observeSingleEvent(of: .value, with: {
            (featuredBooks) in
            for (featuredCategoryIndex, featuredCategoryValue) in ((featuredBooks.children.allObjects as! [FIRDataSnapshot])).enumerated() {
                let featuredTitle = featuredCategoryValue.key
                // check cache (for refreshing etc)
                guard !self.featuredCollectionCache.contains(featuredTitle) else {
                    print("'\(featuredTitle)' already exists!")
                    continue
                }
                if !self.featuredCollectionCache.contains("Spotlights") && !self.featuredCollectionCache.contains("Custom") {
                    self.featuredCollectionCache.append(featuredTitle)
                }
                // Start downloading process
                if !featuredCategoryValue.hasChildren() {
                    self.featuredCollection.append(Featured(name: featuredTitle, typeOfItemsContained: .books, books: [BrowsingBook](), spotlights: [Spotlight]()))
                    self.getBooksFromSections(section: featuredCategoryValue.value as! String, sectionName: featuredTitle, featuredCategoryIndex: featuredCategoryIndex)
                } else {
                    if featuredTitle == "Custom" {
                        // Example: [Custom: [book1, book2, book3 ...]]
                        for customFeaturedList in featuredCategoryValue.children.allObjects as! [FIRDataSnapshot] {
                            let title = customFeaturedList.key
                            let uniqueBookKeys = (customFeaturedList.value as! [String : Bool]).map {$0.key}
                            self.featuredCollection.append(Featured(name: title, typeOfItemsContained: .books, books: [BrowsingBook](), spotlights: [Spotlight]()))
                            self.downloadBrowsingBooks(bookUniqueKeys: uniqueBookKeys, index: featuredCategoryIndex)
                        }
                    } else if featuredTitle == "Spotlight" {
                        // OR: [Spotlight: [Authors Spotlight : ["Ayatullah Mutahhari" : "true"], ["Ayatollah Tabatabai" : "true"], ...]]
                    }
                }
            }
        })
    }
    
    func getBooksFromSections(section: String, sectionName: String, featuredCategoryIndex: Int) {
        // Example: [Ayatullah Murtadha Mutahhari : "Authors"]...
        self.databaseReference.child("Kutub/\(section)/\(sectionName)/Books").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: {
            (snapshot) in
            let bookUniqueKeys = (snapshot.value as! [String : Bool]).map { $0.key }
            self.downloadBrowsingBooks(bookUniqueKeys: bookUniqueKeys, index: featuredCategoryIndex)
        })
    }
    
    func downloadBrowsingBooks(bookUniqueKeys: [String], index: Int) {
        for uniqueBookKey in bookUniqueKeys {
            databaseReference.child("Kutub/Books/" + uniqueBookKey).observeSingleEvent(of: .value, with: {
                (snapshot) in
                let browsingBookValues = snapshot.value as! [String : AnyObject]
                let browsingBook = self.createBrowsingBookObject(data: browsingBookValues, uniqueKey: uniqueBookKey)
                self.featuredCollection[index].books.append(browsingBook)
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
        return featuredCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: "browseCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
        browseCell.configureCell(title: featuredCollection[indexPath.row].name, books: featuredCollection[indexPath.row].books, spotlights: featuredCollection[indexPath.row].spotlights)
    }
}



