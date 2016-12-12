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
    @IBOutlet weak var featuredCategoryName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal var books = [BrowsingBook]()
    internal var spotlights = [Spotlight]()
    internal var cellType: FeaturedItem!
    
    func configureCell(title: String, books: [BrowsingBook], spotlights: [Spotlight]) {
        featuredCategoryName.setTitle(title + " >", for: .normal)
        self.books = books
        self.spotlights = spotlights
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
    }
    
    func configureCell(of type: FeaturedItem, title: String, books: [BrowsingBook], spotlights: [Spotlight]) {
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
        featuredCategoryName.setTitle(title + " >", for: .normal)
        self.cellType = type
        switch type {
        case .books:
            print("")
        case .spotlights:
            print("")
        }
    }

    internal func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate, S: UICollectionViewDataSource>(delegate: D, dataSource: S) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "booksCollectionCell", for: indexPath)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let browseCollectionCell = cell as? BooksCollectionCell else { return }
        let bookTitle = books[indexPath.item].title
        let authors = books[indexPath.item].authors
        browseCollectionCell.configureCell(title: bookTitle, authorNames: authors)
    }
}
