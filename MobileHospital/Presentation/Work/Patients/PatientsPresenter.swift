//
//  PatientsPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class PatientsPresenter<T: PatientsView>: BasePresenter<T> {
    
    var interactor = PatientsInteractor()
    var router = PatientsRouter()
    
    var cellModels: [Any] = []
    var patients: [Patient] = []
    
    func viewDidLoad() {
        refresh()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        for patient in patients {
            let index: Int = patients.firstIndex { (ptnt) -> Bool in
                return patient.id == ptnt.id
                } ?? 0
            let patientCellModel = PatientCellModel(number: "\(index)", name: patient.name, surname: patient.surname, patronymic: patient.patronymic)
            self.cellModels.append(patientCellModel)
        }
    }
    
    func refresh() {
        interactor.getPatients { [weak self] (recieved) in
            guard let `self` = self else { return }
            self.patients = recieved.sorted(by: { (first, second) -> Bool in
                guard let idFirst = Int(first.id) else { return false }
                guard let idSecond = Int(second.id) else { return false }
                return idFirst < idSecond
            })
            self.configureCellModels()
            self.viewState.reloadTable()
        }
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
