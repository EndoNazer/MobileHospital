//
//  Operation.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class Operation: BaseModel {
    var name: String = ""
    var patient: String = ""
    var date: String = ""
    
    init(dictionary: [String: Any]) {
        super.init()
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["Name"] as? String ?? ""
        self.patient = dictionary["Patient"] as? String ?? ""
        self.date = dictionary["Date"] as? String ?? ""
    }
    
    init(id: String, name: String, patient: String, date: String) {
        super.init()
        self.id = id
        self.name = name
        self.patient = patient
        self.date = date
    }
    
    override init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Name": name,
            "Patient": patient,
            "Date": date
        ]
    }
    
}
