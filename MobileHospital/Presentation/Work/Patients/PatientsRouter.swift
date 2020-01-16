//
//  PatientsRouter.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class PatientsRouter: BaseRouter {
    
    func toSinglePatient(patient: Patient) {
        UIViewController.MobileHospital.SinglePatientViewController.show { (vc: SinglePatientViewController) in
            vc.presenter.patient = patient
        }
    }
    
}
