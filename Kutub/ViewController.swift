//
//  ViewController.swift
//  Kutub
//
//  Created by Ali Mir on 11/21/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import FolioReaderKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let config = FolioReaderConfig()
        let bookPath = Bundle.main.path(forResource: "AshuraMisconceptions", ofType: "epub")
        let epubVC = FolioReaderContainer(withConfig: config, epubPath: bookPath!, removeEpub: false)
        
        // Present the epubVC view controller like every other UIViewController instance
        present(epubVC, animated: true, completion: nil)
    }
}
