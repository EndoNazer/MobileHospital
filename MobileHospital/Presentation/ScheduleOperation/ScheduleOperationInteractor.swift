//
//  ScheduleOperationInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ScheduleOperationInteractor: BaseInteractor {
    
    func getLastOperationId(complition: @escaping ((Int) -> Void)) {
        FirebaseFirestoreInteractor.getLastId(collection: "operations") { (lastId) in
            complition(lastId)
        }
    }
    
    func addOperation(operation: Operation, patient: Patient) {
        FirebaseFirestoreInteractor.addNewDocument(collection: "operations", data: operation.toDictionary())
        FirebaseFirestoreInteractor.addOperationToPatient(patient: patient, id: operation.id)
    }
    
}
