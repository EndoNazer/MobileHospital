//
//  Doctor.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class Doctor {
    var id: String = ""
    var name: String = ""
    var surname: String = ""
    var patronymic: String = ""
    var age: String = ""
    var experience: String = ""
    var numberOfPatients: String = ""
    var specialization: String = ""
    var image: String = ""
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.age = dictionary["Age"] as? String ?? ""
        self.experience = dictionary["Experience"] as? String ?? ""
        self.image = dictionary["Image"] as? String ?? ""
        self.name = dictionary["Name"] as? String ?? ""
        self.numberOfPatients = dictionary["NumberOfPatients"] as? String ?? ""
        self.patronymic = dictionary["Patronymic"] as? String ?? ""
        self.specialization = dictionary["Specialization"] as? String ?? ""
        self.surname = dictionary["Surname"] as? String ?? ""
    }
    
    init(id: String, name: String, surname: String, patronymic: String, age: String, experience: String, numberOfPatients: String, specialization: String, image: String) {
        self.id = id
        self.age = age
        self.experience = experience
        self.image = image
        self.name = name
        self.numberOfPatients = numberOfPatients
        self.patronymic = patronymic
        self.specialization = specialization
        self.surname = surname
    }
    
    init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Age": age,
            "Experience": experience,
            "Image": image,
            "Name": name,
            "NumberOfPatients": numberOfPatients,
            "Patronymic": patronymic,
            "Specialization": specialization,
            "Surname": surname
        ]
    }
    
}
