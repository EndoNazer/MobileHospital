//
//  ProfileNSPACell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfileNSPACell: UITableViewCell {
    
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var patronymicLabel: UILabel!
    
    var cellModel: ProfileNSPACellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureWith(name: String, surname: String, patronymic: String) {
        self.nameSurnameLabel.text = surname + " " + name
        self.patronymicLabel.text = patronymic
    }
    
}

//MARK: - TableCellConfigurable

extension ProfileNSPACell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? ProfileNSPACellModel else { return }
        self.cellModel = cellModel
        configureWith(name: cellModel.name, surname: cellModel.surname, patronymic: cellModel.patronymic)
    }
    
}
