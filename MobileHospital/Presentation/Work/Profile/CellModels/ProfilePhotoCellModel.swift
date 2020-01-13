//
//  ProfilePhotoCellModel.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfilePhotoCellModel: TableCellModel {
    
    var reuseIdentifier: String = ProfilePhotoCell.reuseIdentifier
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
}
