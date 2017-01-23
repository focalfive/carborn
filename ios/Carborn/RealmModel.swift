//
//  RealmModel.swift
//  Carborn
//
//  Created by pureye4u on 04/01/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import RealmSwift

class Car: Object {
    static let map: [[String: String]] = [
        [
            "from": "0-100",
            "to": "zero_to_hundred",
            "type": "float"
        ],
        [
            "from": "model",
            "to": "model",
            "type": "string"
        ],
        [
            "from": "brand",
            "to": "brand",
            "type": "string"
        ]
    ]
    dynamic var id = 0
    dynamic var manufacturer = ""
    dynamic var brand = ""
    dynamic var model = ""
    dynamic var carcode = ""
    dynamic var display_name = ""
    dynamic var generation_name = ""
    dynamic var generation_sequence = ""
    dynamic var year = 0
    dynamic var price_eu = 0
    dynamic var price_kr = 0
    dynamic var hp = ""
    dynamic var hp_at_rpm = ""
    dynamic var torque = 0.0
    dynamic var torque_from = 0.0
    dynamic var torque_to = 0.0
    dynamic var engine_position = ""
    dynamic var engine_layout = ""
    dynamic var valves = 0
    dynamic var engine_type1 = ""
    dynamic var engine_type2 = ""
    dynamic var fuel_type = ""
    dynamic var displacement = ""
    dynamic var max_rpm = ""
    dynamic var efficiency = ""
    dynamic var efficiency_sport = ""
    dynamic var cylinders = ""
    dynamic var cylinder_arrangement = ""
    dynamic var discontinue = ""
    dynamic var gearbox_type = ""
    dynamic var gearbox_level = ""
    dynamic var transmission_maker = ""
    dynamic var weight = 0.0
    dynamic var rejection_co2 = 0
    dynamic var zero_to_hundred = 0.0
    dynamic var image_url = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(data: [String: Any]) {
        self.init()
        for item in Car.map {
            guard let from = item["from"],
                let to = item["to"] else {
                    continue
            }
            guard let typed = self.getValueOfType(value: data[from]) else {
                continue
            }
            
            self[to] = typed
        }
    }
    
    convenience init(data: [String: Any], id: Int) {
        self.init(data: data)
        self.id = id
    }
    
    func getValueOfType<T>(value: T) -> Any! {
        switch String(describing: T.self) {
        case "String":
            if let typed = value as? String {
                return typed
            }
            break
            
        case "Double", "Float":
            if let typed = value as? Float {
                return typed
            }
            if let typed = value as? String,
                let numbered = Float(typed) {
                return NSNumber(value: numbered)
            }
            break
            
        case "Int":
            if let typed = value as? Int {
                return typed
            }
            if let typed = value as? String,
                let numbered = Int(typed) {
                return NSNumber(value: numbered)
            }
            break
            
        default:
            return nil
        }
        
        return nil
    }
}

