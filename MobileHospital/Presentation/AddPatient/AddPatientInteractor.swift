//
//  AddPatientInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class AddPatientInteractor: BaseInteractor {
    
    func getLastPatientId(complition: @escaping ((Int) -> Void)) {
        FirebaseFirestoreInteractor.getLastId(collection: "patients") { (lastId) in
            complition(lastId)
        }
    }
    
    func addPatient(patient: Patient) {
        FirebaseFirestoreInteractor.addNewDocument(collection: "patients", data: patient.toDictionary())
        FirebaseFirestoreInteractor.increasePatientsCountAtDoctor()
    }
    
}
