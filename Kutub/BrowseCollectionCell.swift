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
    
    func configureCell(title: String, authorNames: [String]? = nil, imageCover: UIImage? = nil) {
        var authorName = ""
        if let authors = authorNames {
            authorName = authors[0]
            for index in 1..<authors.count {
                authorName += ", \(authors[index])"
            }
        }
        if let image = imageCover {
            bookCover.imageView?.contentMode = .scaleAspectFit
            configureLabelsUI(isImageContained: true)
            bookCover.setImage(image, for: .normal)
            authors.text = authorName
        } else {
            bookCover.imageView?.contentMode = .scaleToFill
            configureLabelsUI(isImageContained: false)
            bookCover.setImage(#imageLiteral(resourceName: "bookCoverPlaceholder"), for: .normal)
            bookTitle.text = title
            authors.text = authorName
        }
    }
    
    func configureLabelsUI(isImageContained: Bool) {
        authors.isUserInteractionEnabled = false
        bookTitle.isUserInteractionEnabled = false
        authors.isHidden = isImageContained
        bookTitle.isHidden = isImageContained
    }
}
