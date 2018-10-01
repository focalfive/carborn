//
//  CarModel.swift
//  carborn
//
//  Created by pureye4u on 04/09/2018.
//  Copyright © 2018 slowslipper. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SwiftyJSON
import ObjectMapper

class CarModel: Object, Mappable {
    
    var index = RealmOptional<Int>()
    var generationSequence = RealmOptional<Int>()
    var year = RealmOptional<Int>()
    var priceKR = RealmOptional<Int>()
    var priceEU = RealmOptional<Int>()
    var hp = RealmOptional<Int>()
    var hpAtRPM = RealmOptional<Int>()
    var torque = RealmOptional<Double>()
    var torqueFrom = RealmOptional<Int>()
    var torqueTo = RealmOptional<Int>()
    var maxRPM = RealmOptional<Int>()
    var efficiency = RealmOptional<Double>()
    var efficiencySport = RealmOptional<Double>()
    var cylinders = RealmOptional<Int>()
    var discontinue = RealmOptional<Int>()
    var gearboxLevel = RealmOptional<Int>()
    var weight = RealmOptional<Double>()
    var displacement = RealmOptional<Double>()
    var rejectionCO2 = RealmOptional<Double>()
    @objc dynamic var manufacturer: String? = nil
    @objc dynamic var brand: String? = nil
    @objc dynamic var modelName: String? = nil
    @objc dynamic var code: String? = nil
    @objc dynamic var displayName: String? = nil
    @objc dynamic var generationName: String? = nil
    @objc dynamic var imageURL: String? = nil
    @objc dynamic var enginePosition: String? = nil
    @objc dynamic var engineLayout: String? = nil
    @objc dynamic var cylinderArrangement: String? = nil
    @objc dynamic var gearboxType: String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.index <- map["index"]
        self.generationSequence <- map["generation_sequence"]
        self.year <- map["year"]
        self.priceKR <- map["price_kr"]
        self.priceEU <- map["price_eu"]
        self.hp <- map["hp"]
        self.hpAtRPM <- map["hp_at_rpm"]
        self.torque <- map["torque"]
        self.torqueFrom <- map["torque_from"]
        self.torqueTo <- map["torque_to"]
        self.maxRPM <- map["max_rpm"]
        self.efficiency <- map["efficiency"]
        self.efficiencySport <- map["efficiency_sport"]
        self.cylinders <- map["cylinders"]
        self.discontinue <- map["discontinue"]
        self.gearboxLevel <- map["gearbox_level"]
        self.weight <- map["weight"]
        self.displacement <- map["displacement"]
        self.rejectionCO2 <- map["rejection_co2"]
        self.manufacturer <- map["manufacturer"]
        self.brand <- map["brand"]
        self.modelName <- map["model"]
        self.code <- map["carcode"]
        self.displayName <- map["display_name"]
        self.generationName <- map["generation_name"]
        self.imageURL <- map["image_url"]
        self.enginePosition <- map["engine_position"]
        self.engineLayout <- map["engine_layout"]
        self.cylinderArrangement <- map["cylinder_arrangement"]
        self.gearboxType <- map["gearbox_type"]
    }
    
}
