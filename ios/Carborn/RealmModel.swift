//
//  RealmModel.swift
//  Carborn
//
//  Created by pureye4u on 04/01/2017.
//  Copyright © 2017 slowslipper. All rights reserved.
//

import RealmSwift

class Car: Object {
    dynamic var id = 0
    dynamic var manufacturer = ""
    dynamic var brand = ""
    dynamic var model = ""
    dynamic var carcode = ""
    dynamic var display_name = ""
    dynamic var generation_name = ""
    dynamic var generation_sequence = ""
    dynamic var year = ""
    dynamic var price = ""
    dynamic var hp = ""
    dynamic var hp_at_rpm = ""
    dynamic var torque = ""
    dynamic var torque_from = ""
    dynamic var torque_to = ""
    dynamic var engine_position = ""
    dynamic var engine_layout = ""
    dynamic var valves = ""
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
    dynamic var weight = ""
    dynamic var rejection_co2 = ""
    dynamic var zero_to_hundred = ""
    dynamic var image_url = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
