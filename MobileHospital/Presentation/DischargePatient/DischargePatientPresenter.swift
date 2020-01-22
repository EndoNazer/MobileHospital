//
//  DischargePatientPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class DischargePatientPresenter<T: DischargePatientView>: BasePresenter<T> {
    
    var interactor = DischargePatientInteractor()
    var router = DischargePatientRouter()
    
    var cellModels: [Any] = []
    var dischargeReport: DischargeReport = DischargeReport()
    var patient: Patient = Patient()
    
    func viewDidLoad() {
        self.configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let dischargePatientCellModel = DischargePatientCellModel { [weak self] (recommendation) in
            guard let `self` = self else { return }
            self.interactor.getLastDischargeReportId { (lastId) in
                self.dischargeReport = DischargeReport(id: "\(lastId + 1)", patient: self.patient.id, diagnosis: self.patient.diagnosis, date: Date().convertDateToNormalDateString(), recommendation: recommendation)
                self.interactor.dischargePatient(patient: self.patient) {
                    self.interactor.addDischargeReport(report: self.dischargeReport)
                    self.saveReport()
                    Events.MessageEvent.post("Пациент выписан")
                    self.router.toWork()
                }
            }
        }
        self.cellModels.append(dischargePatientCellModel)
        
        self.viewState.reloadTable()
    }
    
    private func saveReport() {
        let fileName = "report_" + patient.surname + "_" + dischargeReport.date + ".txt"
        let fileURL = self.interactor.saveToDirectory(data: dischargeReport.toDictionary(), fileName: fileName)
        if let url = fileURL {
            self.interactor.saveFileToStorage(url: url, fileName: fileName)
        }
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}

