//
//  MenuViewModel.swift
//  carborn
//
//  Created by jud.lee on 2019/11/04.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import Foundation
import Firebase

protocol MenuViewModelProrocol {
    
}

class MenuViewModel: NSObject, MenuViewModelProrocol {
    
    override init() {
        
    }
    
    func load() {
        let db = Firestore.firestore()
        db.collection("cars").getDocuments() { (snapshot, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID):\(document.data())")
                }
            }
        }
    }
    
}
