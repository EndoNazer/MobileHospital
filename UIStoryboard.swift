//
//  UIStoryboard.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum MobileHospital: String {
        case Main
        case Authorization
        case Work
        case SinglePatient
        case AddPatient
        
        func getStoryBoard() -> UIStoryboard {
            return UIStoryboard(name: getStoryboardName(), bundle: nil)
        }
        
        func getStoryboardName() -> String {
            return self.rawValue  // <<-- rawvalue
        }
    } 
}
