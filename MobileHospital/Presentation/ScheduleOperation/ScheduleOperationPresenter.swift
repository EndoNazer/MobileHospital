//
//  ScheduleOperationPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ScheduleOperationPresenter<T: ScheduleOperationView>: BasePresenter<T> {
    
    var interactor = ScheduleOperationInteractor()
    var router = ScheduleOperationRouter()
    
    var cellModels: [Any] = []
    var operation: Operation = Operation()
    var patient: Patient = Patient()
    
    func viewDidLoad() {
        self.configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let scheduleOperationCellModel = ScheduleOperationCellModel { [weak self] (name, date) in
            guard let `self` = self else { return }
            self.interactor.getLastOperationId { (lastId) in
                self.operation = Operation(id: "\(lastId + 1)", name: name, patient: self.patient.id, date: date)
                self.interactor.addOperation(operation: self.operation, patient: self.patient)
                Events.MessageEvent.post("Операция добавлена")
                self.viewState.popBack()
            }
        }
        self.cellModels.append(scheduleOperationCellModel)
        
        self.viewState.reloadTable()
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
