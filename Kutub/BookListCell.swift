//
//  BookListCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/9/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BookListCell: UITableViewCell {
    @IBOutlet internal weak var title: UILabel!
    @IBOutlet internal weak var author: UILabel!
    @IBOutlet internal weak var bookCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(bookTitle: String, bookAuthor: String? = nil, bookImage: UIImage? = nil) {
        title.text = bookTitle
        author.text = bookAuthor
        bookCover.image = bookImage
        configureUIState(isAuthorContained: bookAuthor != nil, isImageContained: bookImage != nil)
    }
    
    private func configureUIState(isAuthorContained: Bool, isImageContained: Bool) {
        author.isUserInteractionEnabled = isAuthorContained
        author.isHidden = isAuthorContained
        if !isImageContained {
            bookCover.image = #imageLiteral(resourceName: "bookCoverPlaceholder")
        }
    }
}
