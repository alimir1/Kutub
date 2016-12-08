//
//  BrowseCollectionCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BrowseCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var authors: UILabel!
    
    func configureCell(title: String, author: String) {
        bookTitle.text = title
        authors.text = author
    }
}
