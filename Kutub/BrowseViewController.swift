//
//  BrowseViewController.swift
//  Kutub
//
//  Created by Ali Mir on 12/5/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import Firebase
import FolioReaderKit

class BrowseViewController: UIViewController {
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
//        ref.child("Test/Authors").observe(.value, with: {
//            (snapshot) in
//            
//            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
//                let value = child.value as? NSDictionary
//                if let books = value?["Books"] as? [String : Bool] {
//                    for (key, _) in books {
//                        print("key: \(key)")
//                    }
//                } else {
//                    print("no books :(")
//                }
//            }
////            let value = snapshot.value as? NSDictionary
////            let name = value?["some name"] as? String
////            print("value: \(value), name: \(name)")
//        })
//        ref.child("Test/Books").observe(.value, with: {
//            (snapshot) in
//            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
//                if child.key == "-KYFRAcRcDymZ6xzw1LB" {
//                    print(child.value as! NSDictionary)
//                }
//            }
//            
//        })
//        ref.child("Test/Books").queryOrdered(byChild: "Authors").queryEqual(toValue: "-KYFRAcSzGW0yiIdzClg")
//        ref.child("Test/Books/-KYFRAcRcDymZ6xzw1LB/Authors/-KYFRAcSzGW0yiIdzClg").observe(.value, with: {
//          (snapshot) in
//            if let exists = snapshot.value as? Bool {
//                print (exists)
//            } else {
//                print("nope!")
//            }
//        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let config = FolioReaderConfig()
        let bookPath = Bundle.main.path(forResource: "Jafar al-Tayyar", ofType: "epub")
        let epubVC = FolioReaderContainer(withConfig: config, epubPath: bookPath!, removeEpub: false)
        
        // Present the epubVC view controller like every other UIViewController instance
        present(epubVC, animated: true, completion: nil)
    }
}
