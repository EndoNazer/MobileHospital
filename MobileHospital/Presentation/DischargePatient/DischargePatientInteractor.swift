//
//  DischargePatientInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class DischargePatientInteractor: BaseInteractor {
    
    func getLastDischargeReportId(complition: @escaping ((Int) -> Void)) {
        FirebaseFirestoreInteractor.getLastId(collection: "dischargeReports") { (lastId) in
            complition(lastId)
        }
    }
    
    func dischargePatient(patient: Patient, complition: @escaping (() -> Void)) {
        FirebaseFirestoreInteractor.dischargePatient(patient: patient) {
            complition()
        }
    }
    
    func addDischargeReport(report: DischargeReport) {
        FirebaseFirestoreInteractor.addNewDocument(collection: "dischargeReports", data: report.toDictionary())
    }
    
    func saveFileToStorage(url: URL, fileName: String) {
        FirebaseStorageInteractor.addFileToStorage(url: url, fileName: fileName, folderName: "dischargeReports")
    }
    
    func saveToDirectory(data: [String: Any], fileName: String) -> URL? {
        let fileURL = FileManagerInteractor.saveToDirectory(data: data, fileName: fileName)
        
        return fileURL
    }
    
    private func writeToFile(url: URL, text: String) {
        FileManagerInteractor.writeToFile(url: url, text: text)
    }
    
    private func readFile(url: URL) {
        FileManagerInteractor.readFile(url: url)
    }
    
}
