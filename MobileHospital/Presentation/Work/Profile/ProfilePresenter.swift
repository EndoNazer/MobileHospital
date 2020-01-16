//
//  ProfilePresenter.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfilePresenter<T: ProfileView>: BasePresenter<T> {
    
    var interactor = ProfileInteractor()
    var router = ProfileRouter()
    
    var cellModels: [Any] = []
    private var doctorData: Doctor = Doctor()
    
    func viewDidLoad() {
        if let data = interactor.getDoctorData() {
            doctorData = data
        }
        configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let image: UIImage = SessionData.DoctorAvatar.getValue() ?? UIImage()
        let photoCellModel = PhotoCellModel(image: image)
        cellModels.append(photoCellModel)
        
        let nSPACellModel = NSPACellModel(name: doctorData.name, surname: doctorData.surname, patronymic: doctorData.patronymic, age: doctorData
            .age)
        cellModels.append(nSPACellModel)
        
        let experienceCellModel = SingleInfoCellModel(name: "Стаж", value: doctorData.experience + " " + doctorData.experience.determineTheLastDigitOfAge())
        cellModels.append(experienceCellModel)
        
        let specializationCellModel = SingleInfoCellModel(name: "Специализация", value: doctorData.specialization)
        cellModels.append(specializationCellModel)

        let numberOfPatientsCellModel = SingleInfoCellModel(name: "Количество пациентов", value: doctorData.numberOfPatients)
        cellModels.append(numberOfPatientsCellModel)
        
        let actionCellModel = ActionCellModel(text: "Выйти из аккаунта") {
            Events.UnauthEvent.post()
        }
        cellModels.append(actionCellModel)
    }
    
    func refresh() {
        configureCellModels()
        viewState.reloadTable()
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
