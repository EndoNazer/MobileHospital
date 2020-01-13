//
//  Model.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2""19.
//  Copyright © 2""19 Даниил. All rights reserved.
//

import UIKit

class User {
    var id: String = ""
    var email: String = ""
    var password: String = ""
}

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
}

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
}

class Drug {
    var id: String = ""
    var name: String = ""
    var specialization: String = ""
    var rating: String = ""
}

class Operation {
    var id: String = ""
    var name: String = ""
    var specialization: String = ""
    var patient: String = ""
    var date: String = ""
}

class MonthlyReport {
    var id: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var acceptedPatients: [String] = []
    var acceptedPatientsNumber: String = ""
    var dischargedPatients: [String] = []
    var dischargedPatientsNumber: String = ""
}

class DischargeReport {
    var id: String = ""
    var patient: String = ""
    var diagnosis: String = ""
    var date: String = ""
    var recommendation: String = ""
}
