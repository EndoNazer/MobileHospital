//
//  PatientCell.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class PatientCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var NSPLabel: UILabel!
    
    var cellModel: PatientCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureWith(number: String, name: String, surname: String, patronymic: String) {
        self.numberLabel.text = number
        self.NSPLabel.text = surname + " " + name + " " + patronymic
    }
    
}

extension PatientCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? PatientCellModel else { return }
        self.cellModel = cellModel
        configureWith(number: cellModel.number, name: cellModel.name, surname: cellModel.surname, patronymic: cellModel.patronymic)
    }
    
}
