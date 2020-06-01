//
//  DualDatePickerViewController.swift
//  portal
//
//  Created by Даниил on 21.10.2019.
//  Copyright © 2019 Василий Сомов. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func acceptButtonPressed(date: Date)
}

class DatePickerViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var backgroundView: UIView!
    
    //MARK: - Public Properties
    
    weak var delegate: DatePickerViewControllerDelegate?
    
    //MARK: - @IBActions
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        delegate?.acceptButtonPressed(date: datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        setTapGesture()
        configureDatePickers()
    }
    
    //MARK: - Private functions
    
    private func configureView() {
        self.view.backgroundColor = UIColor.clear
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func configureDatePickers() {
        datePicker.minimumDate = Date()
        datePicker.date = Date()
    }
    
    @objc private func tapHandler() {
        dismiss(animated: true, completion: nil)
    }
    
}
