//
//  CALayer+Border.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import UIKit

extension CALayer {
    
    @objc var borderUIColor: UIColor? {
        get {
            return borderColor == nil ? nil : UIColor(cgColor: borderColor!)
        }
        set {
            borderColor = newValue == nil ? nil : newValue!.cgColor
        }
    }
}
