//
//  ScheduleOperationCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ScheduleOperationCellModel: TableCellModel {
    
    var reuseIdentifier: String = ScheduleOperationCell.reuseIdentifier
    var callback: ((String, String) -> Void)
    
    init(callback: @escaping ((String, String) -> Void)) {
        self.callback = callback
    }
    
}
