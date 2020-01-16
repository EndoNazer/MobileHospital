//
//  ProfilePhotoCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class PhotoCellModel: TableCellModel {
    
    var reuseIdentifier: String = PhotoCell.reuseIdentifier
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
}
