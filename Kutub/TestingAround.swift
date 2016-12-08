//
//  TestingAround.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        ref = FIRDatabase.database().reference()
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


//        let book1 = Book()
//        book1.bookDescription = "Book1 Description"
//        book1.ebookPath = "path1"
//        book1.miscellaneousInformation = "Miscellaneous info1"
//        book1.title = "Book1 Title"
//
//        let book2 = Book()
//        book2.bookDescription = "Book2 Description"
//        book2.ebookPath = "path2"
//        book2.miscellaneousInformation = "Miscellaneous info1"
//        book2.title = "Book2 Title"
//
//        let book3 = Book()
//        book2.bookDescription = "Book2 Description"
//        book2.ebookPath = "path2"
//        book2.miscellaneousInformation = "Miscellaneous info1"
//        book2.title = "Book2 Title"
//
//        let book4 = Book()
//        book2.bookDescription = "Book2 Description"
//        book2.ebookPath = "path2"
//        book2.miscellaneousInformation = "Miscellaneous info1"
//        book2.title = "Book2 Title"
//
//        let translator1 = Translator(value: ["name" : "translator1", "books" : [book1, book3]])
//
//        let translator2 = Translator(value: ["name" : "translator1", "books" : [book1, book2, book3, book4]])

//        let realm = try! Realm()

//        let sdlk = Detail(name: "sdkl", books: )

//        try! realm.write {
//            realm.add([translator1, translator2])
//        }

//    }
