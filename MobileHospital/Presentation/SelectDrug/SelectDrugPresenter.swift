//
//  SelectDrugPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class SelectDrugPresenter<T: SelectDrugView>: BasePresenter<T> {
    
    var interactor = SelectDrugInteractor()
    var router = SelectDrugRouter()
    
    var drugs: [Drug] = []
    var cellModels: [Any] = []
    var selectedDrug: Drug = Drug()
    var patient: Patient = Patient()
    
    func viewDidLoad() {
        self.getDrugs()
        self.configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        for drug in drugs {
            let selectDrugCell = SelectDrugCellModel(number: drug.id, name: drug.name)
            self.cellModels.append(selectDrugCell)
        }
        
        self.viewState.reloadTable()
    }
    
    func getDrugs() {
        Events.ShowLoader.post()
        self.interactor.getDrugs { [weak self] (recievedDrugs) in
            guard let `self` = self else { return }
            self.drugs = recievedDrugs.sorted(by: { (first, second) -> Bool in
                guard let idFirst = Int(first.id) else { return false }
                guard let idSecond = Int(second.id) else { return false }
                return idFirst < idSecond
            })
            self.refresh()
            Events.HideLoader.post()
        }
    }
    
    func refresh() {
        configureCellModels()
        self.viewState.reloadTable()
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
    func addDrugToPatient(index: Int) {
        self.interactor.addDrugToPatient(drug: drugs[index], patient: patient)
        Events.MessageEvent.post("Лекарство назначено")
        self.viewState.popBack()
    }
    
}
