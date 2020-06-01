//
//  DocumentsPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class DocumentsPresenter<T: DocumentsView>: BasePresenter<T> {
    
    var interactor = DocumentsInteractor()
    var router = DocumentsRouter()
    var cellModels: [Any] = []
    
    func viewDidLoad() {
        self.configureCellModels()
    }
    
    func configureCellModels() {
        self.cellModels = []
        
        let actionCellModel = ActionCellModel(text: "Месячный отчет", color: UIColor.green) {
            self.interactor.createMonthlyReport { [weak self] (monthlyReport) in
                guard let `self` = self else { return }
                self.interactor.addReport(monthlyReport: monthlyReport)
                self.saveReport(monthlyReport: monthlyReport)
                Events.MessageEvent.post("Отчет создан")
            }
        }
        self.cellModels.append(actionCellModel)
    }
    
    func getCountCellModels() -> Int {
        return cellModels.count
    }
    
    private func saveReport(monthlyReport: MonthlyReport) {
        let fileName = "report_" + monthlyReport.startDate + "-" + monthlyReport.endDate + ".txt"
        let fileURL = self.interactor.saveToDirectory(data: monthlyReport.toDictionary(), fileName: fileName)
        if let url = fileURL {
            self.interactor.saveFileToStorage(url: url, fileName: fileName)
        }
    }
    
}
