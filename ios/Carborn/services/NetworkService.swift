//
//  NetworkService.swift
//  App29CM
//
//  Created by pureye4u on 24/02/2017.
//  Copyright © 2017 29cm. All rights reserved.
//

import Foundation
import Alamofire

enum httpMethod{
    case GET
    case POST
}

class NetworkService: NSObject {
    
    //MARK: Shared Instance
    static let shared: NetworkService = NetworkService()
    
    var apiUrl: [String: Any] = [:]
    var postMethodDomains: [String] = []
    
    func httpMethod(string: String) -> httpMethod {
        guard let url = URL(string: string), let host = url.host else {
            return .GET
        }
        if postMethodDomains.index(of: host) != nil {
            return .POST
        }
        return .GET
    }
    
    func sendRequest(api: String,
                     message: [String: Any]!,
                     success: @escaping ([String: Any]) -> Void,
                     failure: @escaping (String) -> Void) {
        self.sendRequest(api: api,
                         message: message,
                         seq: 0,
                         success: success,
                         failure: failure)
    }
    
    func sendRequest(api: String,
                     message: [String: Any]!,
                     seq: Int,
                     success: @escaping ([String: Any]) -> Void,
                     failure: @escaping (String) -> Void) {
        var param = message ?? [:]
        param["device"] = "iphone"
        
        guard let url = self.apiUrl[api] else {
            // Denied api type
            return
        }
        
        var urlString: String!
        var hasMoreUrl = false
        if let temp = url as? String {
            urlString = temp
            if seq > 0 {
                //WARNING: apiUrl has only one item
            }
        }
        
        if let temp = url as? [String], temp.count > 0 {
            if(seq < temp.count) {
                urlString = temp[seq]
                if (seq + 1) < temp.count {
                    hasMoreUrl = true
                }
            } else {
                urlString = temp[0]
                //WARNING: apiUrl has only one item
            }
        }
        
        if urlString == nil {
            return
        }
        
        let method = self.httpMethod(string: urlString)
        let failureCallback = hasMoreUrl ? { (errMsg: String) in
            print("retry next seq")
            self.sendRequest(api: api,
                             message: message,
                             seq: seq + 1,
                             success: success,
                             failure: failure)
            } : failure
        self.sendRequest(string: urlString,
                         method: method,
                         message: message,
                         success: success,
                         failure: failureCallback)
    }
    
    func sendRequest(string urlString: String,
                     method: httpMethod,
                     message: [String: Any]!,
                     success: @escaping ([String: Any]) -> Void,
                     failure: @escaping (String) -> Void) {
        
        switch method {
        case .GET:
            Alamofire.request(urlString).responseJSON { response in
                self.checkResponse(response: response,
                                   success: success,
                                   failure: failure)
            }
        case .POST:
            Alamofire.request(urlString, method: .post).responseJSON { response in
                self.checkResponse(response: response,
                                   success: success,
                                   failure: failure)
            }
        }
    }
    
    func checkResponse(response: DataResponse<Any>,
                       success: @escaping ([String: Any]) -> Void,
                       failure: @escaping (String) -> Void) {
        switch response.result {
        case .success:
            success(response.result.value as! [String : Any])
        case.failure(let error):
            failure("\(error)")
        }
    }
}
