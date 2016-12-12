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
    
    func configureCell(image: UIImage) {
        self.spotlightButtonImage.setImage(image, for: .normal)
    }
}
