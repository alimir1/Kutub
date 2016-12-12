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

    var books = [BrowsingBook]()
    
    func configureCell(title: String) {
        featuredCategoryName.setTitle(title + " >", for: .normal)
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
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
        return collectionView.dequeueReusableCell(withReuseIdentifier: "browseCollectionCell", for: indexPath)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let browseCollectionCell = cell as? BrowseCollectionCell else { return }
        let bookTitle = books[indexPath.item].title
        let authors = books[indexPath.item].authors
        browseCollectionCell.configureCell(title: bookTitle, authorNames: authors)
    }
}
