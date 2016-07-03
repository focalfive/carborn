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
    dynamic var born = 0
    dynamic var cylinderArrangement = ""
    dynamic var cylinders = 0
    dynamic var discontinue = 0
    dynamic var displacement = 0
    dynamic var efficiencyEconomy = 0.0
    dynamic var efficiencySport = 0.0
    dynamic var engineLayout = ""
    dynamic var enginePosition = ""
    dynamic var gearboxMaxLevel = 0
    dynamic var gearboxType = ""
    dynamic var hp = 0
    dynamic var hpAtRPM = 0
    dynamic var maker = ""
    dynamic var maxRPM = 0
    dynamic var torque = 0.0
    dynamic var transmission = ""
    dynamic var weight = 0.0
    dynamic var model = ""
    dynamic var mainImage = ""
    
    override static func primaryKey() -> String? {
        return "objectId"
    }
}
