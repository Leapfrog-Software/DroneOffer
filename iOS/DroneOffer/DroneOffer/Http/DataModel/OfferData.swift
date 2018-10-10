//
//  OfferData.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

enum OfferDeliveryWayType: String {
    case app = "0"
    case mail = "1"
    case other = "2"
}

struct OfferData {
    
    let id: String
    var offerer: String
    let contractor: String
    let description: String
    let notes: String
    let deadline: Date
    let deliveryWay: OfferDeliveryWayType
    let deliveryWayOption: String
    let price: Int?
    let score: Int?
    
    init?(data: Dictionary<String, Any>) {
        
        guard let id = data["id"] as? String else {
            return nil
        }
        self.id = id
        
        self.offerer = data["offerer"] as? String ?? ""
        self.contractor = data["contractor"] as? String ?? ""
        self.description = (data["description"] as? String)?.base64Decode() ?? ""
        self.notes = (data["notes"] as? String)?.base64Decode() ?? ""
        
        guard let deadline = DateFormatter(dateFormat: "yyyyMMddHHmmss").date(from: data["deadline"] as? String ?? "") else {
            return nil
        }
        self.deadline = deadline
        
        guard let deliveryWay = OfferDeliveryWayType(rawValue: data["deliveryWay"] as? String ?? "") else {
            return nil
        }
        self.deliveryWay = deliveryWay
        
        self.deliveryWayOption = (data["deliveryWayOption"] as? String)?.base64Decode() ?? ""
        self.price = Int(data["price"] as? String ?? "")
        self.score = Int(data["score"] as? String ?? "")
    }
}
