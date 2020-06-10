//
//  AuthorizationViewController.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Firebase

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var emailField: ImageTextField!
    @IBOutlet weak var passwordField: ImageTextField!
    
    lazy var presenter: AuthorizationPresenter = AuthorizationPresenter(viewState: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignRecognizer()
        configureKeyboard()
        configureTextFieldsEditingRecognizers()
    }
    
    private func configureSignRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(signInViewTapHandler))
        self.signInView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func signInViewTapHandler() {
        guard let text = passwordField.text else {
            shakeAnimation(textField: passwordField)
            return
        }
        if text.count >= 4 {
            presenter.auth(email: emailField.text!, password: passwordField.text!, whenError: { [weak self] in
                guard let `self` = self else { return }
                self.shakeAnimation(textField: self.emailField)
                self.setTextRed(textField: self.emailField)
                self.shakeAnimation(textField: self.passwordField)
                self.setTextRed(textField: self.passwordField)
            })
        } else {
            shakeAnimation(textField: passwordField)
            setTextRed(textField: self.passwordField)
        }
    }
    
    private func configureKeyboard() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditingTapRecognizer))
        self.view.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func endEditingTapRecognizer() {
        self.view.endEditing(true)
    }
    
    @objc override func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc override func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    private func shakeAnimation(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        
        textField.layer.add(animation, forKey: "position")
    }
    
    private func setTextRed(textField: UITextField) {
        textField.textColor = .red
    }
    
    private func configureTextFieldsEditingRecognizers() {
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        emailField.textColor = .black
        passwordField.textColor = .black
    }
    
}

extension AuthorizationViewController: AuthorizationView {
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}
