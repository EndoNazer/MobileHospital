//
//  ProfileNSPAModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class NSPACellModel: TableCellModel {
    
    var reuseIdentifier: String = NSPACell.reuseIdentifier
    var name: String
    var surname: String
    var patronymic: String
    var age: String
    
    init(name: String, surname: String, patronymic: String, age: String) {
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.age = age
    }
    
}
