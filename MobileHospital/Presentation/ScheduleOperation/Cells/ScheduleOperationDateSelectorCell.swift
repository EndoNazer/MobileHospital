//
//  ScheduleOperationDateSelectorCell.swift
//  MobileHospital
//
//  Created by Даниил on 01.06.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ScheduleOperationDateSelectorCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var cellModel: ScheduleOperationDateSelectorCellModel?
    var datePickerAction: (() -> Void) = { }
    
    private var callback: ((String) -> Void) = {(_) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureDateRecognizer()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureDateRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateTapHandler))
        self.dateLabel.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dateTapHandler() {
        datePickerAction()
    }
    
    private func configureWith(date: String?, callback: @escaping ((String) -> Void)) {
        if let date = date {
           dateLabel.text = date
        } else {
            dateLabel.text = "Нажмите, чтобы выбрать название операции"
        }
        
        self.callback = callback
    }
    
}

extension ScheduleOperationDateSelectorCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? ScheduleOperationDateSelectorCellModel else { return }
        self.cellModel = cellModel
        configureWith(date: cellModel.date, callback: cellModel.callback)
    }
    
}
