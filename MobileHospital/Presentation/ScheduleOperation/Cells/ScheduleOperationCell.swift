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
    @IBOutlet weak var dateField: UITextField!
    
    var cellModel: ScheduleOperationCellModel?
    
    private var callback: ((String, String) -> Void) = {(_, _) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureAddRecognizer()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureAddRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTapHandler))
        self.actionView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func addTapHandler() {
        if let name = nameField.text,
            let date = dateField.text{
            
            if name != "", date != "" {
                callback(name, date)
            }
        }
    }
    
    
    private func configureWith(callback: @escaping ((String, String) -> Void)) {
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
