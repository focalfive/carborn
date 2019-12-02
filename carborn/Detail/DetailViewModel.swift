//
//  DetailViewModel.swift
//  carborn
//
//  Created by jud.lee on 2019/11/24.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

protocol DetailViewModelProrocol {
    
    var detailModel: Observable<Detail?> { get }
    
    func load()
    
}

class DetailViewModel: NSObject, DetailViewModelProrocol {
    
    private var _db: Firestore?
    private var db: Firestore {
        if let db = _db {
            return db
        }
        let db = Firestore.firestore()
        _db = db
        return db
    }
    private var id: String?
    private var detailModelSubject = BehaviorSubject<Detail?>(value: nil)
    var detailModel: Observable<Detail?> {
        return detailModelSubject.asObservable()
    }
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
    
    override init() {
        
    }
    
    func load() {
        guard let id = id else {
            return
        }
        db.collection("cars").document(id)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else {
                    guard var obj = snapshot?.data() else {
                        return
                    }
                    obj["id"] = snapshot?.documentID
                    debugPrint("obj", obj)
                    let data = try! JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    debugPrint("data", String(data: data, encoding: .utf8))
                    let model = try! JSONDecoder().decode(Detail.self, from: data)
                    debugPrint("model", model)
                }
        }
    }
    
}
