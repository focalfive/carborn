//
//  CarService.swift
//  carborn
//
//  Created by pureye4u on 07/08/2018.
//  Copyright © 2018 slowslipper. All rights reserved.
//

import Foundation
import Moya

enum CarService {
    case version
//    case brands
    case cars(version: UInt)
//    case car(id: String)
//    case brandCars(brand: String)
//    case modelCars(model: String)
//    case nearCars(id: String)
}

extension CarService: TargetType {
    var API_KEY: String { return "RVBlmzNJ6hMYAruIrDZtDfhUaKGKbbvQ" }
    var headers: [String : String]? {
        switch self {
//        case .brands:
        case .version, .cars:
            return nil
        }
    }
    var baseURL: URL { return URL(string: "https://api.mlab.com/api/1/databases")! }
    var path: String {
        switch self {
//        case .brands:
        case .version, .cars:
            return "/carborn/collections/cars"
        }
    }
    var method: Moya.Method {
        switch self {
//        case .brands:
        case .version, .cars:
            return .get
        }
    }
    var parameters: [String: Any] {
        return ["apiKey": API_KEY]
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
//        case .brands:
        case .version, .cars:
            return URLEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
//        case .brands:
        case .version, .cars:
            return "{}".data(using: .utf8)!
        }
    }
    var task: Task {
        var parameters = self.parameters
        switch self {
//        case .brands:
        case .version:
            parameters["f"] = "{version:1}"
            parameters["s"] = "{version:-1}"
            parameters["l"] = "1"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .cars(let version):
            parameters["q"] = "{version:\(version)}"
            parameters["l"] = "1"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
