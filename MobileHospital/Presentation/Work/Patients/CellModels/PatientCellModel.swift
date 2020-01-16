//
//  PatientCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class PatientCellModel: TableCellModel {
    
    var reuseIdentifier: String = PatientCell.reuseIdentifier
    var number: String
    var name: String
    var surname: String
    var patronymic: String
    
    init(number: String, name: String, surname: String, patronymic: String) {
        self.number = number
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
    }
    
}
