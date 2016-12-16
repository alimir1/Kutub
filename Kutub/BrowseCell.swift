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
    internal var spotlights = [BookReference]()
    internal var cellType: FeaturedItemTypes?
    
    func configureCell(of type: FeaturedItemTypes, title: String, books: [BrowsingBook], spotlights: [BookReference]) {
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
        self.books = books
        self.spotlights = spotlights
        self.cellType = type
        switch type {
        case .reference, .custom:
            featuredCategoryName.isUserInteractionEnabled = true
            featuredCategoryName.setTitle(title + " >", for: .normal)
        case .spotlight:
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
        if let cellType = cellType {
            switch cellType {
            case .reference, .custom:
                return books.count
            case .spotlight:
                return spotlights.count
            }
        } else {
            return 0
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellType = cellType else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "booksCollectionCell", for: indexPath) as! BooksCollectionCell
        }
        
        if cellType == .reference || cellType == .custom {
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
        guard let cellType = cellType else { return CGSize(width: 0, height: 0) }
        if cellType == .spotlight {
            return CGSize(width: 180.0, height: 90.0)
        } else {
            return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        }
    }
}
