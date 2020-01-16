//
//  DischargeReport.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class DischargeReport {
    var id: String = ""
    var patient: String = ""
    var diagnosis: String = ""
    var date: String = ""
    var recommendation: String = ""
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.patient = dictionary["Patient"] as? String ?? ""
        self.diagnosis = dictionary["Diagnosis"] as? String ?? ""
        self.date = dictionary["Date"] as? String ?? ""
        self.recommendation = dictionary["Recommendation"] as? String ?? ""
    }
    
    init(id: String, patient: String, diagnosis: String, date: String, recommendation: String) {
        self.id = id
        self.patient = patient
        self.diagnosis = diagnosis
        self.date = date
        self.recommendation = recommendation
    }
    
    init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Patient": patient,
            "Diagnosis": diagnosis,
            "Date": date,
            "Recommendation": recommendation
        ]
    }
    
}
