//
//  DocumentsInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class DocumentsInteractor: BaseInteractor {
    
    func createMonthlyReport(complition: @escaping ((MonthlyReport) -> Void)) {
        FirebaseFirestoreInteractor.getLastId(collection: "monthlyReports") { [weak self] (lastId) in
            guard let `self` = self else { return }
            let startDate = self.calculateStartDate()
            let endDate = Date()
            self.getPatients(startDate: startDate, endDate: endDate, dateParameter: "DayOfAdmission") { (acceptedPatients) in
                self.getPatients(startDate: startDate, endDate: endDate, dateParameter: "DayOfDischarge") { (dischargedPatients) in
                    let monthlyReport = MonthlyReport(id: "\(lastId + 1)", startDate: startDate.convertDateToNormalDateString(), endDate: endDate.convertDateToNormalDateString(), acceptedPatients: acceptedPatients, acceptedPatientsNumber: "\(acceptedPatients.count)", dischargedPatients: dischargedPatients, dischargedPatientsNumber: "\(dischargedPatients.count)")
                    complition(monthlyReport)
                }
            }
        }
    }
    
    private func getPatients(startDate: Date, endDate: Date, dateParameter: String, complition: @escaping (([String]) -> Void)){
        FirebaseFirestoreInteractor.readAllDocuments(collection: "patients") { (patients) in
            var patientsId: [String] = []
            for patient in patients {
                guard let doc = patient.value as? [String: Any] else { return }
                guard let dayOfAdmission = doc[dateParameter] as? String else { return }
                let date = dayOfAdmission.convertStringWithNormalFormatToDate()
                if (date <= endDate) && (date > startDate) {
                    guard let id = doc["id"] as? String else { return }
                    patientsId.append(id)
                }
            }
            complition(patientsId)
        }
    }
    
    private func calculateStartDate() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = calendar.dateComponents([.year], from: Date()).year
        dateComponents.month = (calendar.dateComponents([.month], from: Date()).month ?? 12) - 1
        dateComponents.day = calendar.dateComponents([.day], from: Date()).day
        return calendar.date(from: dateComponents) ?? Date()
    }
    
    func addReport(monthlyReport: MonthlyReport) {
        FirebaseFirestoreInteractor.addNewDocument(collection: "monthlyReports", data: monthlyReport.toDictionary())
    }
    
    func saveFileToStorage(url: URL, fileName: String) {
        FirebaseStorageInteractor.addFileToStorage(url: url, fileName: fileName, folderName: "monthlyReports")
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
