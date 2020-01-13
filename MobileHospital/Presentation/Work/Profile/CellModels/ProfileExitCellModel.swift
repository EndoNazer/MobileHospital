//
//  ProfileExitCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ProfileExitCellModel: TableCellModel{
    
    var reuseIdentifier: String = ProfileExitCell.reuseIdentifier
    
    var action: (() -> Void)
    
    init(action: @escaping (() -> Void)) {
        self.action = action
    }
    
}
