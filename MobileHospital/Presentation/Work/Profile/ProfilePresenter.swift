//
//  ProfilePresenter.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfilePresenter<T: ProfileView>: BasePresenter<T> {
    
    var cellModels: [Any] = []
    private var doctorData: Doctor = Doctor()
    private var interactor = ProfileInteractor()
    private var router = ProfileRouter()
    
    func viewDidLoad() {
        if let data = interactor.getDoctorData() {
            doctorData = data
        }
        configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let image: UIImage = SessionData.DoctorAvatar.getValue() ?? UIImage()
        let profilePhotoCellModel = ProfilePhotoCellModel(image: image)
        cellModels.append(profilePhotoCellModel)
        
        let profileNSPACellModel = ProfileNSPACellModel(name: doctorData.name, surname: doctorData.surname, patronymic: doctorData.patronymic)
        cellModels.append(profileNSPACellModel)
        
        let experienceCellModel = SingleInfoCellModel(name: "Стаж", value: doctorData.experience)
        cellModels.append(experienceCellModel)
        
        let specializationCellModel = SingleInfoCellModel(name: "Специализация", value: doctorData.specialization)
        cellModels.append(specializationCellModel)

        let numberOfPatientsCellModel = SingleInfoCellModel(name: "Количество пациентов", value: doctorData.numberOfPatients)
        cellModels.append(numberOfPatientsCellModel)
        
        let profileExitCellModel = ProfileExitCellModel {
            Events.UnauthEvent.post()
        }
        cellModels.append(profileExitCellModel)
    }
    
    func refresh() {
        configureCellModels()
        viewState.reloadTable()
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
