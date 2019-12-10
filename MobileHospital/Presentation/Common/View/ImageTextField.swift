//
//  ImageTextField.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

@IBDesignable
class ImageTextField: UITextField {

    // MARK: - Properties
    
    var bottomBorderActivated: Bool = false
    
    // MARK: - Inspectable Properties
    
    @IBInspectable var placeholderImage: UIImage? = nil {
        didSet {
            self.updateView()
        }
    }
    
    @IBInspectable var addBottomBorder:Bool {
        get {
            return self.bottomBorderActivated
        }
        set(newValue) {
            self.bottomBorderActivated = newValue
        }
    }
    
     @IBInspectable var padding: CGFloat = 0

    
    // MARK: - Supplementary methods
    
    // Provides left padding for image
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += padding
        return textRect
    }

    // Provides right padding for image
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }
    
    override func draw(_ rect: CGRect) {
        if bottomBorderActivated {
            self.addBottomBorder(for: rect)
        }
    }
    
    private func updateView() {
        if let image = placeholderImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
    
    private func addBottomBorder(for rect: CGRect) {
        let widthOfBorder = self.borderWidth
        self.borderWidth = 0.0
        self.borderStyle = .none
        let bottomBorderRect = CGRect(x: 0.0, y: rect.height, width: rect.width, height: 0.0)
        let bottomBorderPath = UIBezierPath(rect: bottomBorderRect)
        let borderColor = self.borderColor ?? UIColor.white
        borderColor.setStroke()
        bottomBorderPath.lineWidth = widthOfBorder
        bottomBorderPath.stroke()
    }
    
}
