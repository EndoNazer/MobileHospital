//
//  UserDefaultsInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class UserDefaultsInteractor {
    
    static func getUser() -> User? {
        if let id = UserDefaults.standard.value(forKey: "Id") as? String,
            let email = UserDefaults.standard.value(forKey: "Email") as? String,
        let password = UserDefaults.standard.value(forKey: "Password") as? String{
            let user = User()
            user.id = id
            user.email = email
            user.password = password
            return user
        }
        return nil
    }
    
    static func setUser(user: User) {
        UserDefaults.standard.set(user.id, forKey: "Id")
        UserDefaults.standard.set(user.email, forKey: "Email")
        UserDefaults.standard.set(user.password, forKey: "Password")
        UserDefaults.standard.synchronize()
    }
    
    static func removeUser() {
        UserDefaults.standard.set(nil, forKey: "Id")
        UserDefaults.standard.set(nil, forKey: "Email")
        UserDefaults.standard.set(nil, forKey: "Password")
        UserDefaults.standard.synchronize()
    }
    
}
