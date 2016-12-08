//
//  BrowseCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BrowseCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var featuredCategoryName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    func setFeaturedCategoryTitle(name: String) {
        let titleAttributedString = NSAttributedString(string: "\(name) >")
        featuredCategoryName.setAttributedTitle(titleAttributedString, for: .normal)
    }

    func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate, S: UICollectionViewDataSource>(dataDelegate: D, dataSource: S, forRow row: Int) {
        collectionView.delegate = dataDelegate
        collectionView.dataSource = dataSource
        collectionView.tag = row
        collectionView.reloadData()
    }
}
