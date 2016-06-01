//
//  Car.swift
//  Carborn
//
//  Created by 이재복 on 2016. 5. 29..
//  Copyright © 2016년 slowslipper. All rights reserved.
//
import Foundation
import RealmSwift

class Car: Object {
    dynamic var objectId = ""
    dynamic var maker = ""
    dynamic var model = ""
    
    override static func primaryKey() -> String? {
        return "objectId"
    }
}
