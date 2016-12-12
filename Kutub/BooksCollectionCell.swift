//
//  BrowseCollectionCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BooksCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var bookTitle: UILabel!
    @IBOutlet private weak var authors: UILabel!
    @IBOutlet private weak var bookCover: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
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
    
    internal func configureLabelsUI(isImageContained: Bool) {
        authors.isUserInteractionEnabled = false
        bookTitle.isUserInteractionEnabled = false
        authors.isHidden = isImageContained
        bookTitle.isHidden = isImageContained
    }
}
