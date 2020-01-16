//
//  MonthlyReport.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class MonthlyReport {
    var id: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var acceptedPatients: [String] = []
    var acceptedPatientsNumber: String = ""
    var dischargedPatients: [String] = []
    var dischargedPatientsNumber: String = ""
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.startDate = dictionary["StartDate"] as? String ?? ""
        self.endDate = dictionary["EndDate"] as? String ?? ""
        self.acceptedPatients = dictionary["AcceptedPatients"] as? [String] ?? []
        self.acceptedPatientsNumber = dictionary["AcceptedPatientsNumber"] as? String ?? ""
        self.dischargedPatients = dictionary["DischargedPatients"] as? [String] ?? []
        self.dischargedPatientsNumber = dictionary["DischargedPatientsNumber"] as? String ?? ""
    }
    
    init(id: String, startDate: String, endDate: String, acceptedPatients: [String], acceptedPatientsNumber: String, dischargedPatients: [String], dischargedPatientsNumber: String) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.acceptedPatients = acceptedPatients
        self.acceptedPatientsNumber = acceptedPatientsNumber
        self.dischargedPatients = dischargedPatients
        self.dischargedPatientsNumber = dischargedPatientsNumber
    }
    
    init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "StartDate": startDate,
            "EndDate": endDate,
            "AcceptedPatients": acceptedPatients,
            "AcceptedPatientsNumber": acceptedPatientsNumber,
            "DischargedPatients": dischargedPatients,
            "DischargedPatientsNumber": dischargedPatientsNumber
        ]
    }
    
}
