//
//  ProfileExitCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ActionCellModel: TableCellModel{
    
    var reuseIdentifier: String = ActionCell.reuseIdentifier
    var text: String
    var action: (() -> Void)
    
    init(text: String, action: @escaping (() -> Void)) {
        self.text = text
        self.action = action
    }
    
}
