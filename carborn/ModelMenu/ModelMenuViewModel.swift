//
//  ModelMenuViewModel.swift
//  carborn
//
//  Created by jud.lee on 2019/11/13.
//  Copyright © 2019 jud.lee. All rights reserved.
//

import Foundation
import Firebase
import RxCocoa
import RxSwift

protocol ModelMenuViewModelProrocol {
    
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
}

final class ModelMenuViewModel: ModelMenuViewModelProrocol {
    
    struct Input {
        
    }
    struct Output {
        let menu: Driver<[ModelMenu]>
    }
    
    let input: Input
    let output: Output
    
    private var _db: Firestore?
    private var db: Firestore {
        get {
            if let db = _db {
                return db
            }
            let db = Firestore.firestore()
            _db = db
            return db
        }
    }
    private var id: String?
    private var collectionSubject = BehaviorSubject<[ModelMenu]>(value: [])
    var collection: Observable<[ModelMenu]> {
        get {
            return collectionSubject.asObservable()
        }
    }
    
    init() {
        input = Input()
        output = Output(menu: collectionSubject.asDriver(onErrorJustReturn: []))
    }
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
    
    func load() {
        guard let id = id else {
            return
        }
        db.collection("menu").document(id).getDocument { document, error in
            if let document = document, document.exists {
                if let json = document.data(), let obj = json["submenu"] {
                    let data = try! JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let collection = try! JSONDecoder().decode([ModelMenu].self, from: data)
                    self.collectionSubject.onNext(collection)
                } else {
                    print("data is nil")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
