//
//  ScheduleOperationPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ScheduleOperationPresenter<T: ScheduleOperationView>: BasePresenter<T> {
    
    var interactor = ScheduleOperationInteractor()
    var router = ScheduleOperationRouter()
    
    var nameOperation: String?
    var date: String?
    
    var operation: Operation = Operation()
    var patient: Patient = Patient()
    
    private var errors: [ErrorType: [String]] = [:]
    
    func configureCellModels() -> [Any] {
        var cellModels: [Any] = []
        
        let nameOperationModel = TextCellModel(initialText: nameOperation, placeholderText: "Название операции", additionalText: nil, cellType: .text, errorMessage: errors[.nameOperation]?.first, validationBlock: { [weak self] (error) in
            guard let `self` = self else { return }
            self.errors[.nameOperation] = error != nil ? [error!] : nil
        }) { (text) in
            self.nameOperation = text
        }
        cellModels.append(nameOperationModel)
        
        let dateModel = ScheduleOperationDateSelectorCellModel(date: date) { [weak self] (date) in
            guard let `self` = self else { return }
            self.date = date
        }
        cellModels.append(dateModel)
        
        let actionModel = ActionCellModel(text: "Добавить операцию", color: UIColor.green) { [weak self] in
            guard let `self` = self else { return }
            self.addOperation()
        }
        cellModels.append(actionModel)
        
        return cellModels
    }
    
    private func addOperation() {
        if let name = self.nameOperation, let date = self.date {
            self.interactor.getLastOperationId { (lastId) in
                self.operation = Operation(id: "\(lastId + 1)", name: name, patient: self.patient.id, date: date)
                self.interactor.addOperation(operation: self.operation, patient: self.patient)
                Events.MessageEvent.post("Операция добавлена")
                self.viewState.popBack()
            }
        } else {
            Events.MessageEvent.post("Заполните все поля")
        }
    }
    
}
