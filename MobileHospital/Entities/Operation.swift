//
//  Operation.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class Operation {
    var id: String = ""
    var name: String = ""
    var specialization: String = ""
    var patient: String = ""
    var date: String = ""
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["Name"] as? String ?? ""
        self.specialization = dictionary["Specialization"] as? String ?? ""
        self.patient = dictionary["Patient"] as? String ?? ""
        self.date = dictionary["Date"] as? String ?? ""
    }
    
    init(id: String, name: String, specialization: String, patient: String, date: String) {
        self.id = id
        self.name = name
        self.specialization = specialization
        self.patient = patient
        self.date = date
    }
    
    init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Name": name,
            "Specialization": specialization,
            "Patient": patient,
            "Date": date
        ]
    }
    
}
