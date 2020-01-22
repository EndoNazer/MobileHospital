//
//  SinglePatientRouter.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SinglePatientRouter: BaseRouter {
    
    func toAddOperation(patient: Patient) {
        UIViewController.MobileHospital.ScheduleOperationViewController.show { (vc: ScheduleOperationViewController) in
            vc.presenter.patient = patient
        }
    }
    
    func toAddDrug(patient: Patient) {
        UIViewController.MobileHospital.SelectDrugViewController.show { (vc: SelectDrugViewController) in
            vc.presenter.patient = patient
        }
    }
    
    func toDischargePatient(patient: Patient) {
        UIViewController.MobileHospital.DischargePatientViewController.show { (vc: DischargePatientViewController) in
            vc.presenter.patient = patient
        }
    }
    
}
