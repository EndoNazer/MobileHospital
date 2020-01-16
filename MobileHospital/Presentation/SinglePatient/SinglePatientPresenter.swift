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
        
        let actionCellModel = ActionCellModel(text: "Выписать пациента") {
            
        }
        self.cellModels.append(actionCellModel)
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
