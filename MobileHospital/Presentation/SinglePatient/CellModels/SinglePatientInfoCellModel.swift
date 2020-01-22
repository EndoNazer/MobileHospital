//
//  SinglePatientDischargeCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class SinglePatientInfoCellModel: TableCellModel {
    
    var reuseIdentifier: String = SinglePatientInfoCell.reuseIdentifier
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
}
