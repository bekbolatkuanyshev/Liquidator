//
//  APIManager.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 16.04.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

private let baseURL = "http://35.187.6.231/api/"

class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    
    static var headerType = Int()
    
    
    // Enum с собственными видами ошибок для более точного Error handling
    
    enum BackendError: Error {
        case objectSerialization(reason: String)
    }
//    Mj0Te5J
    
    func joinGame(parameters: Dictionary<String, Any>, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let endPoint = "login"
        let method = HTTPMethod.post
        
        APIManager.headerType = 4
        requestOnAPI(endPoint: endPoint,
                     method: method,
                     parameters: parameters,
                     onSuccess: onSuccess,
                     onFailure: onFailure)
    }
    
    func getGame(parameters: Dictionary<String, Any>, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let endPoint = "getaboutgame"
        let method = HTTPMethod.get
        
        APIManager.headerType = 4
        requestOnAPI(endPoint: endPoint,
                     method: method,
                     parameters: parameters,
                     onSuccess: onSuccess,
                     onFailure: onFailure)
        
    }
    
    func logIn(parameters: Dictionary<String, Any>, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let endPoint = "login"
        let method = HTTPMethod.post
        
        requestOnAPI(endPoint: endPoint,
                     method: method,
                     parameters: parameters,
                     onSuccess: onSuccess,
                     onFailure: onFailure)
    }
    
    func createGame(parameters: Dictionary<String, Any>, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let endPoint = "creategame"
        let method = HTTPMethod.post
        
        APIManager.headerType = 4
        requestOnAPI(endPoint: endPoint,
                     method: method,
                     parameters: parameters,
                     onSuccess: onSuccess,
                     onFailure: onFailure)
    }
    
    func register(parameters: Dictionary<String, Any>, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        let endPoint = "register"
        let method = HTTPMethod.post
        
        requestOnAPI(endPoint: endPoint,
                     method: method,
                     parameters: parameters,
                     onSuccess: onSuccess,
                     onFailure: onFailure)
    }
    
    func requestOnAPI(endPoint: String, method: HTTPMethod, parameters: Dictionary<String, Any>,
                      onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void) {
        
        var headers: HTTPHeaders = [:]
        
        switch APIManager.headerType {
        case 1:
            headers = ["Authorization":UserDefaults.standard.value(forKey: "token") as! String]
        case 2:
            headers = ["Access":UserDefaults.standard.value(forKey: "access_key") as! String]
        case 3:
            headers = ["Device":UserDefaults.standard.value(forKey: "device_id") as! String]
        case 4:
            headers = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "token") as! String)"
            ]

        default:
            headers = [:]
        }
        
        Alamofire.request("\(baseURL)\(endPoint)", method: method, parameters: parameters, headers: headers)
            .responseJSON { response in
                
                print("------------------------------------------------------")
                print("url: \(baseURL)\(endPoint), params: \(parameters)")
                
                guard response.result.error == nil else {
                    print(response.result.error!)
                    onFailure(response.result.error!)
                    return
                }
                
                guard response.result.value != nil else {
                    onFailure(BackendError.objectSerialization(reason: "Couldn't get JSON object from API"))
                    return
                }
                
                guard let object = response.result.value else {
                    print("error")
                    return
                }
                
                let json = JSON(object)
                onSuccess(json)
                
        }
        
    }
    
}

