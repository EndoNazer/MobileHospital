//
//  ScheduleOperationCell.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ScheduleOperationCell: UITableViewCell {
    
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    var cellModel: ScheduleOperationCellModel?
    var datePickerAction: (() -> Void) = { }
    
    private var date: Date?
    
    private var callback: ((String) -> Void) = {(_) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureAddRecognizer()
        configureDateRecognizer()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureAddRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTapHandler))
        self.actionView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func addTapHandler() {
        if let name = nameField.text{
            if name != "" {
                callback(name)
            } else {
                Events.MessageEvent.post("Название обязательно для заполнения")
            }
        } else {
            Events.MessageEvent.post("Название обязательно для заполнения")
        }
    }
    
    private func configureDateRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateTapHandler))
        self.dateLabel.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dateTapHandler() {
        datePickerAction()
    }
    
    private func configureWith(callback: @escaping ((String) -> Void)) {
        self.callback = callback
    }
    
}

extension ScheduleOperationCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? ScheduleOperationCellModel else { return }
        self.cellModel = cellModel
        configureWith(callback: cellModel.callback)
    }
    
}
