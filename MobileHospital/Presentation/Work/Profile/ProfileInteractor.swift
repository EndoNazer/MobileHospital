//
//  ProfileInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfileInteractor: BaseInteractor {
 
    func getDoctorData() -> Doctor? {
        guard let doctorData: Doctor = SessionData.SelectedDoctor.getValue() else { return nil }
        return doctorData
    }
    
}
