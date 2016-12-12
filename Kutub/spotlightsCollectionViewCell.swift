//
//  spotlightsCollectionViewCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/12/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class spotlightsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var spotlightButtonImage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(image: UIImage) {
        spotlightButtonImage.imageView?.contentMode = .scaleAspectFill
        spotlightButtonImage.setImage(image, for: .normal)
    }
}
