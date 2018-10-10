//
//  UserDetailViewController.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018年 Leapfrog-Inc. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    private var userData: UserData!
    
    func set(userData: UserData) {
        self.userData = userData
    }
    
    @IBAction func onTapBack(_ sender: Any) {
        self.pop(animationType: .horizontal)
    }

    @IBAction func onTapFavorite(_ sender: Any) {
        
    }
    
    @IBAction func onTapChat(_ sender: Any) {
        
    }
    
    @IBAction func onTapOffer(_ sender: Any) {
        
    }
}
