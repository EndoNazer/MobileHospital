//
//  ViewController.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBAction func buttonPressed(_ sender: Any) {
        UIViewController.MobileHospital.ViewController2.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ref = Database.database().reference()
        
        ref.child("Department/Doctor/Name").setValue("LOLKEK")
        
    }


}
