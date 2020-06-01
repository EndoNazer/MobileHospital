//
//  ProfileExitCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ActionCellModel: TableCellModel{
    
    var reuseIdentifier: String = ActionCell.reuseIdentifier
    var text: String
    var color: UIColor
    var action: (() -> Void)
    
    init(text: String, color: UIColor, action: @escaping (() -> Void)) {
        self.text = text
        self.color = color
        self.action = action
    }
    
}
