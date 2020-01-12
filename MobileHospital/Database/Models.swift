//
//  Model.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class User {
    var id: String = ""
    var email: String = ""
    var password: String = ""
}

class Doctor {
    var id: Int64 = 0
    var name: String = ""
    var surname: String = ""
    var patronymic: String = ""
    var age: Int = 0
    var experience: Int = 0
    var numberOfPatients: Int = 0
    var specialization: String = ""
}

class Patient {
    var id: Int64 = 0
    var name: String = ""
    var surname: String = ""
    var patronymic: String = ""
    var age: Int = 0
    var diagnosis: String = ""
    var drugs: [Int64] = []
    var operations: [Int64] = []
    var doctor: Int64 = 0
}

class Drug {
    var id: Int64 = 0
    var name: String = ""
    var specialization: String = ""
    var rating: Int = 0
}

class Operation {
    var id: Int64 = 0
    var name: String = ""
    var specialization: String = ""
    var patient: Int64 = 0
    var date: String = ""
}

class MonthlyReport {
    var id: Int64 = 0
    var startDate: String = ""
    var endDate: String = ""
    var acceptedPatients: [Int64] = []
    var acceptedPatientsNumber: Int = 0
    var dischargedPatients: [Int64] = []
    var dischargedPatientsNumber: Int = 0
}

class DischargeReport {
    var id: Int64 = 0
    var patient: Int64 = 0
    var diagnosis: String = ""
    var date: String = ""
    var recommendation: String = ""
}
