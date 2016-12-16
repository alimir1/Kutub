//
//  BrowseCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BrowseCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var featuredCategoryName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal var books = [BrowsingBook]()
    internal var spotlights = [SpotLight]()
    internal var cellType: FeaturedItemTypes = .reference
    
    func configureCell(of type: FeaturedItemTypes, title: String, books: [BrowsingBook], spotlightBookKeys: [SpotLight]) {
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
        self.books = books
        switch type {
        case .reference, .custom:
            featuredCategoryName.isUserInteractionEnabled = true
            featuredCategoryName.setTitle(title + " >", for: .normal)
        case .spotlights:
            featuredCategoryName.setTitle(title, for: .normal)
            featuredCategoryName.isUserInteractionEnabled = false
        }
    }

    func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate, S: UICollectionViewDataSource>(delegate: D, dataSource: S) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let myCollectionView = UICollectionView(frame: self.collectionView.bounds, collectionViewLayout: collectionViewFlowLayout)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        collectionView.reloadData()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellType == .reference {
            return books.count
        } else if cellType == .spotlights {
            return spotlights.count
        } else {
            return 0
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellType == .reference {
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
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if cellType == .spotlights {
            return CGSize(width: 175.0, height: 90.0)
        } else {
            return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        }
    }
}
