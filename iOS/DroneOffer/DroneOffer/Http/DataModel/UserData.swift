//
//  UserData.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//
import Foundation

struct UserArea {
    let pref: String
    let cities: [String]
    
    init?(data: String) {
        let prefCities = data.components(separatedBy: "/")
        guard prefCities.count == 2 else {
            return nil
        }
        self.pref = prefCities[0]
        self.cities = prefCities[1].components(separatedBy: "|")
    }
}

struct UserPrice {
    let name: String
    let price: Int
    
    init?(data: String) {
        let namePrice = data.components(separatedBy: "/")
        guard namePrice.count == 2 else {
            return nil
        }
        let name = namePrice[0]
        guard let price = Int(namePrice[1]) else {
            return nil
        }
        self.name = name
        self.price = price
    }
}

struct UserExpenses {
    let name: String
    let expenses: Int
    
    init?(data: String) {
        let nameExpenses = data.components(separatedBy: "/")
        guard nameExpenses.count == 2 else {
            return nil
        }
        let name = nameExpenses[0]
        guard let expenses = Int(nameExpenses[1]) else {
            return nil
        }
        self.name = name
        self.expenses = expenses
    }
}

struct UserBank {
    let bankName: String
    let branchName: String
    let account: String
    
    init(data: String) {
        let separated = data.components(separatedBy: "/")
        if separated.count == 3 {
            self.bankName = separated[0]
            self.branchName = separated[1]
            self.account = separated[2]
        } else {
            self.bankName = ""
            self.branchName = ""
            self.account = ""
        }
    }
}

struct UserData {
    
    let id: String
    var nickname: String
    var areas: [UserArea]
    var message: String
    var prices: [UserPrice]
    var expenses: [UserExpenses]
    var bank: UserBank
    
    init?(data: Dictionary<String, Any>) {
        
        guard let id = data["id"] as? String else {
            return nil
        }
        self.id = id
        
        self.nickname = (data["nickname"] as? String)?.base64Decode() ?? ""
        self.areas = (data["area"] as? String ?? "").components(separatedBy: "-").compactMap { UserArea(data: $0) }
        self.message = (data["message"] as? String)?.base64Decode() ?? ""
        self.prices = (data["price"] as? String ?? "").components(separatedBy: "-").compactMap { UserPrice(data: $0) }
        self.expenses = (data["expenses"] as? String ?? "").components(separatedBy: "-").compactMap { UserExpenses(data: $0) }
        self.bank = UserBank(data: data["bank"] as? String ?? "")
    }
}

