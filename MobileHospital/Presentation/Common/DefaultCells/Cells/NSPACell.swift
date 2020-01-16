//
//  ProfileNSPACell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class NSPACell: UITableViewCell {
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var patronymicLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var cellModel: NSPACellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureWith(name: String, surname: String, patronymic: String, age: String) {
        self.nameSurnameLabel.text = surname + " " + name
        self.patronymicLabel.text = patronymic
        self.ageLabel.text = age + " " + age.determineTheLastDigitOfAge()
    }
    
}

//MARK: - TableCellConfigurable

extension NSPACell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? NSPACellModel else { return }
        self.cellModel = cellModel
        configureWith(name: cellModel.name, surname: cellModel.surname, patronymic: cellModel.patronymic, age: cellModel.age)
    }
    
}
