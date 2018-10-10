//
//  ApiManager.swift
//  DroneOffer
//
//  Created byLeapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

class ApiManager {
    
    class func post(params: [String: String]?, completion: @escaping ((Bool, Any?) -> ())) {
        
        HttpManager.post(url: Constants.ServerApiUrl, params: params) { result, data in
            if result, let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any> {
                        completion(true, json)
                        return
                    }
                } catch {}
            }
            completion(false, nil)
        }
    }
}
