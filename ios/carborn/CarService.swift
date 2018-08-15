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
    case brands
//    case cars
//    case car(id: String)
//    case brandCars(brand: String)
//    case modelCars(model: String)
//    case nearCars(id: String)
}

extension CarService: TargetType {
    var API_KEY: String { return "RVBlmzNJ6hMYAruIrDZtDfhUaKGKbbvQ" }
    var headers: [String : String]? {
        switch self {
        case .brands:
            return nil
        }
    }
    var baseURL: URL { return URL(string: "https://api.mlab.com/api/1/databases")! }
    var path: String {
        switch self {
        case .brands:
            return "/carborn/collections/cars"
        }
    }
    var method: Moya.Method {
        switch self {
        case .brands:
            return .get
        }
    }
    var parameters: [String: Any]? {
        let params = ["apiKey": API_KEY]
//        switch self {
//        case .brands:
//            return nil
//        }
        return params
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .brands:
            return URLEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
        case .brands:
            return "{}".data(using: .utf8)!
        }
    }
    var task: Task {
        switch self {
        case .brands:
            return .requestParameters(parameters: self.parameters!, encoding: URLEncoding.default)
        }
    }
}
