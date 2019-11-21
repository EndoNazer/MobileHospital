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
//        case Auth
//        case Work
//        case Clients
//        case SearchOrder
//        case Deliveries
//        //case OrderDetail
//        case Claims
//        case ClaimDetails
//        case MultySelect
//        case Association
//        case Services
//        case DebtDetails
//        case PharmPromo
//        case Invoices
//        case ReturnablePackages
        case Main
        
        func getStoryBoard() -> UIStoryboard {
            return UIStoryboard(name: getStoryboardName(), bundle: nil)
        }
        
        func getStoryboardName() -> String {
            return self.rawValue  // <<-- rawvalue
        }
    } 
}
