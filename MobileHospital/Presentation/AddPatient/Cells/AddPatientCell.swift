//
//  AddPatientCell.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class AddPatientCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var patronymicField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var diagnosisField: UITextField!
    @IBOutlet weak var photoLinkField: UITextField!
    @IBOutlet weak var addButtonView: UIView!
    
    var cellModel: AddPatientCellModel?
    
    private var callback: ((String, String, String, String, String, String) -> Void) = {(_, _, _, _, _, _) in }
    
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
        self.addButtonView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func addTapHandler() {
        if let name = nameField.text,
            let surname = surnameField.text,
            let patronymic = patronymicField.text,
            let age = ageField.text,
            let diagnosis = diagnosisField.text,
            let photoLink = photoLinkField.text{
            
            if name != "", surname != "", patronymic != "", age != "", diagnosis != "", photoLink != "" {
                callback(name, surname, patronymic, age, diagnosis, photoLink)
            }
        }
    }
        
        
        private func configureWith(callback: @escaping ((String, String, String, String, String, String) -> Void)) {
            self.callback = callback
        }
        
    }
    
    extension AddPatientCell: TableCellConfigurable {
        
        func config(cellModel: TableCellModel) {
            guard let cellModel = cellModel as? AddPatientCellModel else { return }
            self.cellModel = cellModel
            configureWith(callback: cellModel.callback)
        }
        
}
