//
//  SelectDrugCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class SelectDrugCellModel: TableCellModel {
    
    var reuseIdentifier: String = SelectDrugCell.reuseIdentifier
    var number: String
    var name: String
    
    init(number: String, name: String) {
        self.number = number
        self.name = name
    }
    
}
