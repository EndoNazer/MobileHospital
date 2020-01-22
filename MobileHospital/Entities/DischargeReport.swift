//
//  DischargeReport.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class DischargeReport: BaseModel {
    var patient: String = ""
    var diagnosis: String = ""
    var date: String = ""
    var recommendation: String = ""
    
    init(dictionary: [String: Any]) {
        super.init()
        self.id = dictionary["id"] as? String ?? ""
        self.patient = dictionary["Patient"] as? String ?? ""
        self.diagnosis = dictionary["Diagnosis"] as? String ?? ""
        self.date = dictionary["Date"] as? String ?? ""
        self.recommendation = dictionary["Recommendation"] as? String ?? ""
    }
    
    init(id: String, patient: String, diagnosis: String, date: String, recommendation: String) {
        super.init()
        self.id = id
        self.patient = patient
        self.diagnosis = diagnosis
        self.date = date
        self.recommendation = recommendation
    }
    
    override init() {
        
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
