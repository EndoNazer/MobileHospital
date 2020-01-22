//
//  ProfileInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfileInteractor: BaseInteractor {
 
    func getDoctorData(complition: @escaping ((Doctor) -> Void)){
        guard let doctorData: Doctor = SessionData.SelectedDoctor.getValue() else { return }
        FirebaseFirestoreInteractor.readSingleDocument(collection: "doctors", id: doctorData.id) { (recieved) in
            let doctor = Doctor(dictionary: recieved)
            SessionData.SelectedDoctor.saveValue(doctor)
            complition(doctor)
        }
    }
    
}
