//
//  InfoCell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class SingleInfoCellModel: TableCellModel {
    
    var reuseIdentifier: String = SingleInfoCell.reuseIdentifier
    var name: String
    var value: String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
}
