//
//  FetchUserRequester.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

class FetchUserRequester {
    
    static let shared = FetchUserRequester()
    
    var dataList = [UserData]()
    
    func fetch(completion: @escaping ((Bool) -> ())) {
        
        let params = ["command": "getUser"]
        ApiManager.post(params: params) { [weak self] result, data in
            if result, let dic = data as? Dictionary<String, Any> {
                if (dic["result"] as? String) == "0", let users = (dic["users"] as? Array<Dictionary<String, Any>>) {
                    self?.dataList = users.compactMap { UserData(data: $0) }
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
    
    func query(id: String) -> UserData? {
        return self.dataList.filter { $0.id == id }.first
    }
}
