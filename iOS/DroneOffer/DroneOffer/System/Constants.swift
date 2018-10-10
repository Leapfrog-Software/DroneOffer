//
//  Constants.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import Foundation

class Constants {
    
//    static let ServerRootUrl = "http://lfrogs.sakura.ne.jp/drone_offer/"
    static let ServerRootUrl = "http://localhost/drone_offer/"
    static let ServerApiUrl = Constants.ServerRootUrl + "srv.php"
    static let ServerUserImageRootUrl = Constants.ServerRootUrl + "data/image/user/"
    static let ServerDeliverablesRootUrl = Constants.ServerRootUrl + "data/deliverables/"
    
    static let StringEncoding = String.Encoding.utf8
    static let HttpTimeOutInterval = TimeInterval(10)
    
    struct UserDefaultsKey {
        static let Version = "Version"
        static let UserId = "UserId"
    }
}
