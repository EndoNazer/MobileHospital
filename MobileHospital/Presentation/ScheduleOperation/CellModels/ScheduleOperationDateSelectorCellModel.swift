//
//  ScheduleOperationDateSelectorCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 01.06.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ScheduleOperationDateSelectorCellModel: TableCellModel {
    
    var reuseIdentifier: String = ScheduleOperationDateSelectorCell.reuseIdentifier
    var date: String?
    var callback: ((String) -> Void)
    
    init(date: String?, callback: @escaping ((String) -> Void)) {
        self.date = date
        self.callback = callback
    }
    
}
