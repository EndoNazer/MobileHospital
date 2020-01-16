//
//  PatientsInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class PatientsInteractor: BaseInteractor {
    
    func getPatients(complition: @escaping (([Patient]) -> Void)) {
        Events.ShowLoader.post()
        FirebaseFirestoreInteractor.getPatients { (recieved) in
            complition(recieved)
            Events.HideLoader.post()
        }
    }
    
}
