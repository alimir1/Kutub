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
    @IBOutlet weak var bookCover: UIButton!
    
    func configureCell(title: String, author: String, imageCover: UIImage? = nil) {
        if let image = imageCover {
            configureLabelsUI(isContainsImage: true)
            bookCover.setImage(image, for: .normal)
        } else {
            configureLabelsUI(isContainsImage: false)
            bookTitle.text = title
            authors.text = author
        }
    }
    
    func configureLabelsUI(isContainsImage: Bool) {
        authors.isHidden = isContainsImage
        bookTitle.isHidden = isContainsImage
    }
}
