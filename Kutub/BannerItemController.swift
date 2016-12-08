//
//  BannerItemController.swift
//  Kutub
//
//  Created by Ali Mir on 12/8/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BannerItemController: UIViewController {
    
    @IBOutlet weak var buttonImage: UIButton!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            buttonImage.setImage(image, for: .normal)
            buttonImage.addTarget(self, action: #selector(self.buttonClicked), for: UIControlEvents.touchUpInside)
        }
    }
    
    func buttonClicked() {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "book")
//        present(vc, animated: true, completion: nil)
    }
}
