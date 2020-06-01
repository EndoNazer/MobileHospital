//
//  CustomTextField.swift
//  MobileHospital
//
//  Created by Даниил on 19.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
            self.text = text
        }
        return success
    }
    
}
