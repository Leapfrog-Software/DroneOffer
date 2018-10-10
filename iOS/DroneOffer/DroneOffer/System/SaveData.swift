//
//  SaveData.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

class SaveData {
    
    static let shared = SaveData()
    
    private var currentVersion = "1"
    
    var userId = ""
    
    init() {
        let userDefaults = UserDefaults()
        
        if userDefaults.string(forKey: Constants.UserDefaultsKey.Version) != self.currentVersion {
            return
        }
        
        self.userId = userDefaults.string(forKey: Constants.UserDefaultsKey.UserId) ?? ""
    }
    
    func save() {
        
        let userDefaults = UserDefaults()
        
        userDefaults.set(self.currentVersion, forKey: Constants.UserDefaultsKey.Version)
        userDefaults.set(self.userId, forKey: Constants.UserDefaultsKey.UserId)
        
        userDefaults.synchronize()
    }
}
