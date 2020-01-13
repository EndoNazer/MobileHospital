//
//  BaseRouter.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class BaseRouter {
    
    func toWork() {
        UIViewController.MobileHospital.WorkViewController.showAsRoot { (vc: WorkViewController) in
            vc.switchTab(to: .patients)
        }
    }
    
}
