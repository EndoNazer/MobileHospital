//
//  SelectDrugInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class SelectDrugInteractor: BaseInteractor {
    
    func getDrugs(complition: @escaping (([Drug]) -> Void)) {
        FirebaseFirestoreInteractor.readAllDocuments(collection: "drugs") { (recieved) in
            var drugs: [Drug] = []
            for value in recieved.values {
                guard let drugData = value as? [String: Any] else { return }
                let drug = Drug(dictionary: drugData)
                drugs.append(drug)
            }
            complition(drugs)
        }
    }
    
    func addDrugToPatient(drug: Drug, patient: Patient) {
        FirebaseFirestoreInteractor.addDrugToPatient(patient: patient, id: drug.id)
    }
    
}
