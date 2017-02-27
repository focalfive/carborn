//
//  ModelListView.swift
//  Carborn
//
//  Created by pureye4u on 28/02/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import UIKit
import RealmSwift

class ModelListView: UIView {
    
    var brandName: String!
    private var _modelIndex = -1
    var modelIndex: Int {
        get {
            return self._modelIndex
        }
        set {
            if self._modelIndex != newValue {
                let realm = try! Realm()
                
                let cars = realm.objects(Car.self)
                self._modelIndex = newValue
                
            }
        }
    }
    var currentModelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.resizeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeViews() {
        let viewSize = self.frame.size
        var frame = CGRect.zero
        
        frame.size = viewSize
        self.currentModelLabel.frame = frame
    }
}
