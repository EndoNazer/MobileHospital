//
//  User.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class User: BaseModel {
    var email: String = ""
    var password: String = ""
    
    init(dictionary: [String: Any]) {
        super.init()
        self.id = dictionary["id"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        self.password = dictionary["Password"] as? String ?? ""
    }
    
    init(id: String, email: String, password: String) {
        super.init()
        self.id = id
        self.email = email
        self.password = password
    }
    
    override init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Email": email,
            "Password": password
        ]
    }
    
}
