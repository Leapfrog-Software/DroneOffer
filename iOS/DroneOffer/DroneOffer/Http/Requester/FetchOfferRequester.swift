//
//  FetchOfferRequester.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

class FetchOfferRequester {
    
    static let shared = FetchOfferRequester()
    
    var dataList = [OfferData]()
    
    func fetch(completion: @escaping ((Bool) -> ())) {
        
        let params = ["command": "getOffer"]
        ApiManager.post(params: params) { [weak self] result, data in
            if result, let dic = data as? Dictionary<String, Any> {
                if (dic["result"] as? String) == "0", let offers = (dic["offers"] as? Array<Dictionary<String, Any>>) {
                    self?.dataList = offers.compactMap { OfferData(data: $0) }
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
    
    func query(id: String) -> OfferData? {
        return self.dataList.filter { $0.id == id }.first
    }
}
