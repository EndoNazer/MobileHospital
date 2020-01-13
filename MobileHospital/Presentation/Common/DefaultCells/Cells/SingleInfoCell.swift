//
//  SingleInfoCell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SingleInfoCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var cellModel: SingleInfoCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureWith(name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value
    }
    
}

//MARK: - TableCellConfigurable

extension SingleInfoCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? SingleInfoCellModel else { return }
        self.cellModel = cellModel
        configureWith(name: cellModel.name, value: cellModel.value)
    }
    
}
