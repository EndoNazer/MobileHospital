//
//  ProfileNSPAModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ProfileNSPACellModel: TableCellModel {
    
    var reuseIdentifier: String = ProfileNSPACell.reuseIdentifier
    var name: String
    var surname: String
    var patronymic: String
    
    init(name: String, surname: String, patronymic: String) {
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
    }
    
}
