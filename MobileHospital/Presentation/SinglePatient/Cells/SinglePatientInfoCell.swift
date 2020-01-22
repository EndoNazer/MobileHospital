//
//  SinglePatientDischargeCell.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SinglePatientInfoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellModel: SinglePatientInfoCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureWith(title: String) {
        self.titleLabel.text = title
    }
    
}

extension SinglePatientInfoCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? SinglePatientInfoCellModel else { return }
        self.cellModel = cellModel
        configureWith(title: cellModel.title)
    }
    
}
