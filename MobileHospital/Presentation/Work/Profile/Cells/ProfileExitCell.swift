//
//  ProfileExitCell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ProfileExitCell: UITableViewCell {
    
    @IBOutlet weak var content: UIView!
    
    var cellModel: ProfileExitCellModel?
    var action: (() -> Void) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureRecognizer()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        content.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func tapHandler() {
        action()
    }
    
    private func configureWith(action: @escaping (() -> Void)) {
        self.action = action
    }
    
}

//MARK: - TableCellConfigurable

extension ProfileExitCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? ProfileExitCellModel else { return }
        self.cellModel = cellModel
        configureWith(action: cellModel.action)
    }
    
}
