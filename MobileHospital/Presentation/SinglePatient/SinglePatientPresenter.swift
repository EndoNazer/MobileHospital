//
//  SinglePatientPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SinglePatientPresenter<T: SinglePatientView>: BasePresenter<T> {
    
    var interactor = SinglePatientInteractor()
    var router = SinglePatientRouter()
    
    var cellModels: [Any] = []
    var patient: Patient = Patient()
    
    private var image = UIImage()
    
    func viewDidLoad() {
        getImage()
        configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let photoCellModel = PhotoCellModel(image: self.image)
        self.cellModels.append(photoCellModel)
        
        let profileNSPACellModel = NSPACellModel(name: self.patient.name, surname: self.patient.surname, patronymic: self.patient.patronymic, age: self.patient.age)
        self.cellModels.append(profileNSPACellModel)
        
        let dateOfAdmissionCellModel = SingleInfoCellModel(name: "День поступления", value: self.patient.dayOfAdmission)
        self.cellModels.append(dateOfAdmissionCellModel)
        
        let diagnosisCellModel = SingleInfoCellModel(name: "Диагноз", value: self.patient.diagnosis)
        self.cellModels.append(diagnosisCellModel)
        
        if patient.dayOfDischarge == "" {
            let addDrugActionCellModel = ActionCellModel(text: "Назначить лекарство", color: UIColor.green) { [weak self] in
                guard let `self` = self else { return }
                self.router.toAddDrug(patient: self.patient)
            }
            self.cellModels.append(addDrugActionCellModel)
            
            let addOperationActionCellModel = ActionCellModel(text: "Добавить операцию", color: UIColor.green) { [weak self] in
                guard let `self` = self else { return }
                self.router.toAddOperation(patient: self.patient)
            }
            self.cellModels.append(addOperationActionCellModel)
            
            let dischargeActionCellModel = ActionCellModel(text: "Выписать пациента", color: UIColor.red) { [weak self] in
                guard let `self` = self else { return }
                self.router.toDischargePatient(patient: self.patient)
            }
            self.cellModels.append(dischargeActionCellModel)
        } else {
            let dischargeCellModel = SinglePatientInfoCellModel(title: "Пациент выписан " + patient.dayOfDischarge)
            self.cellModels.append(dischargeCellModel
            )
        }
    }
    
    private func getImage() {
        self.interactor.getImage(image: patient.image) { [weak self] (img) in
            guard let `self` = self else { return }
            self.image = img
            self.refresh()
        }
    }
    
    func refresh() {
        configureCellModels()
        viewState.reloadTable()
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
