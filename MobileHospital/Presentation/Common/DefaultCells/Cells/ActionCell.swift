//
//  ProfileExitCell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var displayedTextLabel: UILabel!
    
    var cellModel: ActionCellModel?
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
    
    private func configureWith(text: String, action: @escaping (() -> Void)) {
        self.displayedTextLabel.text = text
        self.action = action
    }
    
}

//MARK: - TableCellConfigurable

extension ActionCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? ActionCellModel else { return }
        self.cellModel = cellModel
        configureWith(text: cellModel.text, action: cellModel.action)
    }
    
}
