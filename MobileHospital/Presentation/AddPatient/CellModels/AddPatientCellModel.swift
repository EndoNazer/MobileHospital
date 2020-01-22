//
//  AddPatientCell.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class AddPatientCellModel: TableCellModel {
    
    var reuseIdentifier: String = AddPatientCell.reuseIdentifier
    var callback: ((String, String, String, String, String, String) -> Void)
    
    init(callback: @escaping ((String, String, String, String, String, String) -> Void)) {
        self.callback = callback
    }
    
}
