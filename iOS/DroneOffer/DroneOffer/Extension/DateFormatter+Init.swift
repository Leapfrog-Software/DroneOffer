//
//  DateFormatter+Init.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    convenience init(dateFormat: String) {
        self.init()
        
        self.locale = Locale(identifier: "ja_JP")
        self.calendar = Calendar(identifier: .gregorian)
        self.dateFormat = dateFormat
    }
}
