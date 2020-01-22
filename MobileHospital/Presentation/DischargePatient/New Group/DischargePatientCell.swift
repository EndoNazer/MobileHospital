//
//  DischargePatientCell.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class DischargePatientCell: UITableViewCell {
    
    @IBOutlet weak var recommendationView: UITextView!
    @IBOutlet weak var actionView: UIView!
    
    var cellModel: DischargePatientCellModel?
    
    private var callback: ((String) -> Void) = {(_) in }
    
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
        if let recommendation = recommendationView.text{
            callback(recommendation)
        }
    }
    
    private func configureWith(callback: @escaping ((String) -> Void)) {
        self.callback = callback
    }
    
}

extension DischargePatientCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? DischargePatientCellModel else { return }
        self.cellModel = cellModel
        configureWith(callback: cellModel.callback)
    }
    
}
