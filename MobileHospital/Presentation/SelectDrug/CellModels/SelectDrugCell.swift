//
//  SelectDrugCell.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SelectDrugCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var cellModel: SelectDrugCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureWith(number: String, name: String) {
        self.numberLabel.text = number
        self.nameLabel.text = name
    }
    
}

extension SelectDrugCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? SelectDrugCellModel else { return }
        self.cellModel = cellModel
        configureWith(number: cellModel.number, name: cellModel.name)
    }
    
}
