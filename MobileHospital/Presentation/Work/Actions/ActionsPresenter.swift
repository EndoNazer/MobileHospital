//
//  ActionsPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class ActionsPresenter<T: ActionsView>: BasePresenter<T> {
    
    var interactor = ActionsInteractor()
    var router = ActionsRouter()
    var cellModels: [Any] = []
    
    func viewDidLoad() {
        self.configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
}
