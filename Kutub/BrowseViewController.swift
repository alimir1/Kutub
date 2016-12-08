//
//  BrowseViewController.swift
//  Kutub
//
//  Created by Ali Mir on 12/5/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var example = [[BrowsingBook]]()
    var categories = [String]()
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
        
        example = [[browsingBook1, browsingBook2, browsingBook1, browsingBook2],
                   [browsingBook1, browsingBook1]]
        
        categories = ["Qu'ran and Other Studies", "Understanding Islam"]
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: "browseCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return example[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "browseCollectionCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let browseCollectionCell = cell as? BrowseCollectionCell else { return }
        let authorName = example[collectionView.tag][indexPath.item].authors[0].name
        let bookTitle = example[collectionView.tag][indexPath.item].title
        browseCollectionCell.configureCell(title: bookTitle, author: authorName)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
        browseCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        browseCell.setCollectionViewDataSourceDelegate(dataDelegate: self, dataSource: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let browseCell = cell as? BrowseCell else { return }
        storedOffsets[indexPath.row] = browseCell.collectionViewOffset
    }
}



