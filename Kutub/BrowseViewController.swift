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
    var allBooks = [[BrowsingBook]]()
    var featuredCategoryNames = [String]()
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authors = [Info(name: "An author goes here so this is test.", uniqueKey: "")]
        let authors1 = [Info(name: "Short author name", uniqueKey: "")]
        let publishers = [Info(name: "publisher1", uniqueKey: "")]
        let translators = [Info(name: "translator1", uniqueKey: "")]
        let featuredCategories = [Info(name: "translator1", uniqueKey: "")]
        let tags = [Info(name: "translator1", uniqueKey: "")]
        
        let browsingBook1 = BrowsingBook(title: "Some Book Title Goes Here", bookDescription: "", miscellaneousInformation: "", uniqueKey: "", authors: authors, publishers: publishers, tags: tags, translators: translators, featuredCategories: featuredCategories)
        
        let browsingBook2 = BrowsingBook(title: "Another Title", bookDescription: "", miscellaneousInformation: "", uniqueKey: "", authors: authors1, publishers: publishers, tags: tags, translators: translators, featuredCategories: featuredCategories)
        
        allBooks = [[browsingBook1, browsingBook2, browsingBook1, browsingBook2],
                   [browsingBook1, browsingBook1],
                   [browsingBook1, browsingBook2, browsingBook1],
                   [browsingBook1, browsingBook2, browsingBook1, browsingBook1, browsingBook1, browsingBook1],
                   [browsingBook1, browsingBook1, browsingBook1, browsingBook1],
                   [browsingBook1, browsingBook1, browsingBook1, browsingBook1],
                   [browsingBook1, browsingBook2, browsingBook1, browsingBook1, browsingBook1, browsingBook1]]
        
        let ref = FIRDatabase.database().reference()
        // TODO: - DON'T FORGET TO REMOVE OBSERVERS ONCE YOU'RE DONE!!!
        ref.child("FeaturedBooksCategories").observe(.value, with: {
            (snapshot) in
            var featuredCategoryNames = [String]()
            for item in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if !item.hasChildren() {
                    featuredCategoryNames.append(item.key)
                } else {
                    // custom category with books.
                }
            }
            self.featuredCategoryNames = featuredCategoryNames
            self.tableView.reloadData()
        })
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredCategoryNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: "browseCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
        browseCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        browseCell.setFeaturedCategoryTitle(name: featuredCategoryNames[indexPath.row])
        browseCell.setCollectionViewDataSourceDelegate(dataDelegate: self, dataSource: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
        storedOffsets[indexPath.row] = browseCell.collectionViewOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBooks[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "browseCollectionCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let browseCollectionCell = cell as? BrowseCollectionCell else { return }
        let authorName = allBooks[collectionView.tag][indexPath.item].authors[0].name
        let bookTitle = allBooks[collectionView.tag][indexPath.item].title
        browseCollectionCell.configureCell(title: bookTitle, author: authorName, imageCover: #imageLiteral(resourceName: "40hadith"))
    }
}



