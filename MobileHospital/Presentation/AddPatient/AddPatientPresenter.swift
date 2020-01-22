//
//  AddPatientPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class AddPatientPresenter<T: AddPatientView>: BasePresenter<T> {
 
    var interactor = AddPatientInteractor()
    var router = AddPatientRouter()
    
    var cellModels: [Any] = []
    var patient: Patient = Patient()
    
    func viewDidLoad() {
        self.configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let addPatientCellModel = AddPatientCellModel { [weak self] (name, surname, patronymic, age, diagnosis, photoLink) in
            guard let `self` = self else { return }
            self.interactor.getLastPatientId { (lastId) in
                guard let doctor: Doctor = SessionData.SelectedDoctor.getValue() else { return }
                self.patient = Patient(id: "\((lastId + 1))", name: name, surname: surname, patronymic: patronymic, age: age, diagnosis: diagnosis, drugs: [], operations: [], doctor: doctor.id, dayOfAdmission: Date().convertDateToNormalDateString(), dayOfDischarge: "", image: photoLink)
                self.interactor.addPatient(patient: self.patient)
                Events.MessageEvent.post("Пациент добавлен")
                self.viewState.popBack()
            }
        }
        self.cellModels.append(addPatientCellModel)
        
        self.viewState.reloadTable()
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
