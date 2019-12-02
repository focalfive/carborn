//
//  DetailModel.swift
//  carborn
//
//  Created by jud.lee on 2019/12/02.
//  Copyright © 2019 jud.lee. All rights reserved.
//


import Foundation

struct Detail: Codable {
    var id: String?
    var brand: String
    var code: String
    var displayName: String
    var generationName: String
    var generationSequence: Double
    var manufacturer: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case brand
        case code = "carcode"
        case displayName = "display_name"
        case generationName = "generation_name"
        case generationSequence = "generation_sequence"
        case manufacturer
    }
}
