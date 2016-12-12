//
//  BrowseCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BrowseCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var featuredCategoryName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal var books = [BrowsingBook]()
    internal var spotlights = [SpotLight]()
    internal var cellType: FeaturedItem!
    
    func configureCell(of type: FeaturedItem, title: String, books: [BrowsingBook], spotlightBookKeys: [SpotLight]) {
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
        if type == .spotlights {
            featuredCategoryName.setTitle(title, for: .normal)
            featuredCategoryName.isUserInteractionEnabled = false
        } else if type == .books {
            featuredCategoryName.isUserInteractionEnabled = true
            featuredCategoryName.setTitle(title + " >", for: .normal)
        }
        self.cellType = type
        self.books = books
        self.spotlights = spotlightBookKeys
    }

    internal func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate, S: UICollectionViewDataSource>(delegate: D, dataSource: S) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellType == .books {
            return books.count
        } else if cellType == .spotlights {
            return spotlights.count
        } else {
            return 0
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellType == .books {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "booksCollectionCell", for: indexPath) as! BooksCollectionCell
            let bookTitle = books[indexPath.item].title
            let authors = books[indexPath.item].authors
            cell.configureCell(title: bookTitle, authorNames: authors)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spotlightsCollectionCell", for: indexPath) as! spotlightsCollectionViewCell
            cell.configureCell(image: #imageLiteral(resourceName: "testImage"))
            return cell
        }
    }
}
