//
//  ServiceManager.swift
//  GithubHelper
//
//  Created by Mahmoud Amer on 10/4/18.
//  Copyright © 2018 Amer. All rights reserved.
//

import Foundation
import Alamofire
import Reachability

class ServicesManager {
    
    public static func searchAPI(searchKeywork: String, completion: @escaping (BaseModel)->(), error: @escaping (String)->()) {
        
        let reachability = Reachability()
        if reachability?.connection == .none ||  reachability?.connection.description == "No Connection"{
            error(NetworkError.networkError.rawValue)
        } else {
            var url: String = "\(APIConstants.baseSearchURL.rawValue)q=\(searchKeywork)"
            url = url.replacingOccurrences(of: " ", with: "+")
            print("url : \(url)")
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    //First, check for request error
                    if let requestError = response.error {
                        error(requestError.localizedDescription)
                        return
                    }
                    
                    if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                        if let baseModel = try? JSONDecoder().decode(BaseModel.self, from: data) {
                            completion(baseModel)
                        } else {
                            //Json Error
                            error(NetworkError.jsonError.rawValue)
                        }
                    } else {
                        //No response from server
                        error(NetworkError.noResponseError.rawValue)
                    }
            }
        }
    }
    
    public static func getSubscribers(subscribtionsURL: String, completion: @escaping ([Owner])->(), error: @escaping (String)->()) {
        
        let reachability = Reachability()
        if reachability?.connection == .none ||  reachability?.connection.description == "No Connection"{
            error(NetworkError.networkError.rawValue)
        } else {
            var url: String = subscribtionsURL
            url = url.replacingOccurrences(of: " ", with: "+")
            print("url : \(url)")
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in
                    //First, check for request error
                    if let requestError = response.error {
                        error(requestError.localizedDescription)
                        return
                    }
                    
                    if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                        if let subscribers = try? JSONDecoder().decode([Owner].self, from: data) {
                            completion(subscribers)
                        } else {
                            //Json Error
                            error(NetworkError.jsonError.rawValue)
                        }
                    } else {
                        //No response from server
                        error(NetworkError.noResponseError.rawValue)
                    }
            }
        }
    }
}


