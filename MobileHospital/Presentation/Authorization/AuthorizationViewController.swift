//
//  AuthorizationViewController.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Firebase

class AuthorizationViewController: UIViewController {
    
    @IBAction func action(_ sender: Any) {
        UIViewController.MobileHospital.WorkViewController.showAsRoot()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
