//
//  Patients.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class Patient {
    var id: String = ""
    var name: String = ""
    var surname: String = ""
    var patronymic: String = ""
    var age: String = ""
    var diagnosis: String = ""
    var drugs: [String] = []
    var operations: [String] = []
    var doctor: String = ""
    var dayOfAdmission: String = ""
    var dayOfDischarge: String = ""
    var image: String = ""
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["Name"] as? String ?? ""
        self.surname = dictionary["Surname"] as? String ?? ""
        self.patronymic = dictionary["Patronymic"] as? String ?? ""
        self.age = dictionary["Age"] as? String ?? ""
        self.diagnosis = dictionary["Diagnosis"] as? String ?? ""
        self.drugs = dictionary["Drugs"] as? [String] ?? []
        self.operations = dictionary["Operations"] as? [String] ?? []
        self.doctor = dictionary["Doctor"] as? String ?? ""
        self.dayOfAdmission = dictionary["DayOfAdmission"] as? String ?? ""
        self.dayOfDischarge = dictionary["DayOfDischarge"] as? String ?? ""
        self.image = dictionary["Image"] as? String ?? ""
    }
    
    init(id: String, name: String, surname: String, patronymic: String, age: String, diagnosis: String, drugs: [String], operations: [String], doctor: String, dayOfAdmission: String, dayOfDischarge: String, image: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.age = age
        self.diagnosis = diagnosis
        self.drugs = drugs
        self.operations = operations
        self.doctor = doctor
        self.dayOfAdmission = dayOfAdmission
        self.dayOfDischarge = dayOfDischarge
        self.image = image
    }
    
    init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Name": name,
            "Surname": surname,
            "Patronymic": patronymic,
            "Age": age,
            "Diagnosis": diagnosis,
            "Drugs": drugs,
            "Operations": operations,
            "Doctor": doctor,
            "DayOfAdmission": dayOfAdmission,
            "DayOfDischarge": dayOfDischarge,
            "Image": image,
        ]
    }
    
}
