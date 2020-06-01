//
//  AddPatientPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class AddPatientPresenter<T: AddPatientView>: BasePresenter<T> {
    
    var interactor = AddPatientInteractor()
    var router = AddPatientRouter()
    
    var patient: Patient = Patient()
    
    private var name: String?
    private var surname: String?
    private var patronymic: String?
    private var age: String?
    private var diagnosis: String?
    private var photo: String?
    
    private var errors: [ErrorType: [String]] = [:]
    
    func viewDidLoad() {
        //self.configureCellModels()
    }
    
    func configureCellModels() -> [Any] {
        var cellModels: [Any] = []
        
        let nameModel = TextCellModel(initialText: name, placeholderText: "Имя", additionalText: nil, cellType: .text, errorMessage: errors[.firstName]?.first, validationBlock: { [weak self] (error) in
            guard let `self` = self else { return }
            self.errors[.firstName] = error != nil ? [error!] : nil
        }) { (text) in
            self.name = text
        }
        cellModels.append(nameModel)
        
        let surnameModel = TextCellModel(initialText: surname, placeholderText: "Фамилия", additionalText: nil, cellType: .text, errorMessage: errors[.lastName]?.first, validationBlock: { [weak self] (error) in
            guard let `self` = self else { return }
            self.errors[.lastName] = error != nil ? [error!] : nil
        }) { (text) in
            self.surname = text
        }
        cellModels.append(surnameModel)
        
        let patronymicModel = TextCellModel(initialText: patronymic, placeholderText: "Отчество", additionalText: nil, cellType: .text, errorMessage: errors[.patronymic]?.first, validationBlock: { [weak self] (error) in
            guard let `self` = self else { return }
            self.errors[.patronymic] = error != nil ? [error!] : nil
        }) { (text) in
            self.patronymic = text
        }
        cellModels.append(patronymicModel)
        
        let ageModel = TextCellModel(initialText: age, placeholderText: "Возраст", additionalText: nil, cellType: .age, errorMessage: errors[.age]?.first, validationBlock: { [weak self] (error) in
            guard let `self` = self else { return }
            self.errors[.age] = error != nil ? [error!] : nil
        }) { (text) in
            self.age = text
        }
        cellModels.append(ageModel)
        
        let diagnosisModel = TextCellModel(initialText: diagnosis, placeholderText: "Диагноз", additionalText: nil, cellType: .text, errorMessage: errors[.diagnosis]?.first, validationBlock: { [weak self] (error) in
            guard let `self` = self else { return }
            self.errors[.diagnosis] = error != nil ? [error!] : nil
        }) { (text) in
            self.diagnosis = text
        }
        cellModels.append(diagnosisModel)
        
        let photoModel = TextCellModel(initialText: photo, placeholderText: "Ссылка на фото", additionalText: nil, cellType: .free, errorMessage: nil, validationBlock: {(_) in}) { (text) in
            self.photo = text
        }
        cellModels.append(photoModel)
        
        let actionModel = ActionCellModel(text: "Добавить пациента", color: UIColor.green) { [weak self] in
            guard let `self` = self else { return }
            self.interactor.getLastPatientId { (lastId) in
                guard let doctor: Doctor = SessionData.SelectedDoctor.getValue() else { return }
                self.addPatient(doctor: doctor, lastId: lastId)
            }
        }
        cellModels.append(actionModel)
        
        return cellModels
    }
    
    private func addPatient(doctor: Doctor, lastId: Int) {
        guard let name = self.name else { sendErrorMessage(); return }
        guard let surname = self.surname else { sendErrorMessage(); return }
        guard let patronymic = self.patronymic else { sendErrorMessage(); return }
        guard let age = self.age else { sendErrorMessage(); return }
        guard let diagnosis = self.diagnosis else { sendErrorMessage(); return }
        if name != "", surname != "", patronymic != "", age != "", diagnosis != "" {
            self.patient = Patient(id: "\((lastId + 1))", name: name, surname: surname, patronymic: patronymic, age: age, diagnosis: diagnosis, drugs: [], operations: [], doctor: doctor.id, dayOfAdmission: Date().convertDateToNormalDateString(), dayOfDischarge: "", image: photo ?? "")
            self.interactor.addPatient(patient: self.patient)
            Events.MessageEvent.post("Пациент добавлен")
            self.viewState.popBack()
        } else {
            sendErrorMessage()
        }
    }
    
    private func sendErrorMessage() {
        Events.MessageEvent.post("Произошла ошибка")
    }
    
}
