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
    var featuredCollection = [CompleteCollection]()
    var databaseReference: FIRDatabaseReference!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        self.tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(getDataFromFirebase), for: .valueChanged)
        databaseReference = FIRDatabase.database().reference()
        getDataFromFirebase()
    }
    
    func getDataFromFirebase() {
        databaseReference.child("FeaturedBooksCategories").observeSingleEvent(of: .value, with: {
            (featuredBooks) in
            var collections = [CompleteCollection]()
            var index = 0
            for featuredCategoryValue in featuredBooks.children.allObjects as! [FIRDataSnapshot] {
                let featuredTitle = featuredCategoryValue.key
                if !featuredCategoryValue.hasChildren() {
                    let bookRef = BookReference(section: featuredCategoryValue.value as! String, sectionName: featuredTitle)
                    let collection = CompleteCollection(name: featuredTitle, type: .reference, reference: Reference(reference: bookRef))
                    collections.append(collection)
                    self.getBooks(from: featuredCategoryValue.value as! String, sectionName: featuredTitle, index: index, type: .reference)
                    index += 1
                } else {
                    if featuredTitle == "Customs" {
                        // Example: [Customs: ["ishraq custom" : [book1, book2, book3 ...]]]
                        for customFeaturedList in featuredCategoryValue.children.allObjects as! [FIRDataSnapshot] {
                            let title = customFeaturedList.key
                            let uniqueBookKeys = (customFeaturedList.value as! [String : Bool]).map {$0.key}
                            let collection = CompleteCollection(name: title, type: .custom, custom: Custom())
                            collections.append(collection)
                            self.downloadBrowsingBooks(title: title, bookUniqueKeys: uniqueBookKeys, index: index, type: .custom)
                            index += 1
                        }
//                    } else if featuredTitle == "Spotlights" {
                        // OR: [Spotlight: [Authors Spotlight : ["Ayatullah Mutahhari" : "true"], ["Ayatollah Tabatabai" : "true"], ...]]
//                        for spotlight in featuredCategoryValue.children.allObjects as! [FIRDataSnapshot] {
//                            let title = spotlight.key
//                            collection.append(Featured(name: title, type: .spotlights))
//                            let spotlightItems = spotlight.value as! [String : String]
//                            for (name, section) in spotlightItems {
//                                self.getBooksFromSections(section: section, sectionName: name, featuredCategoryIndex: featuredCategoryIndex, isSpotlight: true)
//                            }
//                        }
                    }
                }
            }
            self.featuredCollection = collections
            self.tableView.reloadData()
        })
    }
    
    func getBooks(from section: String, sectionName: String, index: Int, type: FeaturedItemTypes) {
        // Example: [Ayatullah Murtadha Mutahhari : "Authors"]...
        self.databaseReference.child("Kutub/\(section)/\(sectionName)/Books").queryLimited(toFirst: 25).observeSingleEvent(of: .value, with: {
            (snapshot) in
            let bookUniqueKeys = (snapshot.value as! [String : Bool]).map { $0.key }
            switch type {
            case .reference:
                self.downloadBrowsingBooks(title: sectionName, bookUniqueKeys: bookUniqueKeys, index: index, type: type)
            default: return
            }
        })
    }
    
    func downloadBrowsingBooks(title: String, bookUniqueKeys: [String], index: Int, type: FeaturedItemTypes) {
        databaseReference.child("Kutub/Books/").observeSingleEvent(of: .value, with: {
            (snapshot) in
            var books = [BrowsingBook]()
            for snapshot in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if bookUniqueKeys.contains(snapshot.key) {
                    let browsingBookValues = snapshot.value as! [String : AnyObject]
                    let browsingBook = self.createBrowsingBookObject(data: browsingBookValues, uniqueKey: snapshot.key)
                    books.append(browsingBook)
                }
            }
            switch type {
            case .reference:
                self.featuredCollection[index].reference?.books = books
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            case .custom: ()
                self.featuredCollection[index].custom!.books = books
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            default: return
            }
        })
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
        switch featuredCollection[indexPath.row].type {
        case .reference:
            browseCell.configureCell(of: featuredCollection[indexPath.row].type, title: featuredCollection[indexPath.row].name, books: featuredCollection[indexPath.row].reference!.books, spotlightBookKeys: [SpotLight]())
        case .custom:
            browseCell.configureCell(of: featuredCollection[indexPath.row].type, title: featuredCollection[indexPath.row].name, books: featuredCollection[indexPath.row].custom!.books, spotlightBookKeys: [SpotLight]())
        default: return
        }
    }
}
