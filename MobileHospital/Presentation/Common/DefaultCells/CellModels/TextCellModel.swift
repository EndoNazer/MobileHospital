//
//  TextCellModel.swift
//  Ladoshki
//
//  Created by Даниил on 16.03.2020.
//  Copyright © 2020 MediaSoft. All rights reserved.
//

import Foundation
import CoreGraphics

class TextCellModel: TableCellModel {
    
    var reuseIdentifier: String = TextCell.reuseIdentifier
    var initialText: String?
    var placeholderText: String
    var additionalText: String?
    var cellType: TextCellType
    var errorMessage: String?
    var validationBlock: ((String?) -> Void)
    var complitionBlock: ((String) -> Void)
    
    init(initialText: String?, placeholderText: String, additionalText: String?, cellType: TextCellType, errorMessage: String?, validationBlock: @escaping((String?) -> Void), complitionBlock: @escaping ((String) -> Void)) {
        self.initialText = initialText
        self.placeholderText = placeholderText
        self.additionalText = additionalText
        self.cellType = cellType
        self.errorMessage = errorMessage
        self.validationBlock = validationBlock
        self.complitionBlock = complitionBlock
    }
    
}
