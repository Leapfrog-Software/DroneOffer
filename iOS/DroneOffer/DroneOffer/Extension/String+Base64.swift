//
//  String+Base64.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

extension String {
    
    func base64Encode() -> String? {
        let data = self.data(using: Constants.StringEncoding)
        return data?.base64EncodedString()
    }
    
    func base64Decode() -> String? {
        let replaced = self.replacingOccurrences(of: " ", with: "+")
        if let data = Data(base64Encoded: replaced) {
            return String(data: data, encoding: Constants.StringEncoding)
        }
        return nil
    }
}
