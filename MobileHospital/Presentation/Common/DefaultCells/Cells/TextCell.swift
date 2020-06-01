//
//  TextCell.swift
//  Ladoshki
//
//  Created by Даниил on 16.03.2020.
//  Copyright © 2020 MediaSoft. All rights reserved.
//

import UIKit

enum TextCellType {
    case free
    case freeNumber
    case text
    case accountNumber
    case phoneNumber
    case password
    case email
    case code
    case age
}

class TextCell: UITableViewCell{
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordEyeImageView: UIImageView!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var additionalLabelLeadingConstraint: NSLayoutConstraint!
    
    var cellModel: TextCellModel?
    
    private var type: TextCellType = .text
    private var validationBlock: ((String?) -> Void) = {_ in }
    private var complitionBlock: ((String) -> Void) = {_ in }
    private var containedText: String?
    private var errorText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureEyeRecognizer()
        textField.delegate = self
    }
    
    private func configureCell() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    private func configureEyeRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        passwordEyeImageView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func tapHandler() {
        textField.isSecureTextEntry.toggle()
    }
    
    private func configureWith(cellModel: TextCellModel) {
        setToDefaultState()
        
        type = cellModel.cellType
        
        containedText = cellModel.initialText
        errorText = cellModel.errorMessage
        
        placeholderLabel.text = cellModel.placeholderText
        validationBlock = cellModel.validationBlock
        complitionBlock = cellModel.complitionBlock
        
        if type != .password {
            passwordEyeImageView.isHidden = true
        } else {
            passwordEyeImageView.isHidden = false
            textField.isSecureTextEntry = true
        }
        
        configureTextField()
        configureAdditionalLabel()
        configureErrorLabel()
        configureKeyboard()
    }
    
    private func setToDefaultState() {
        textField.text = nil
        textField.isSecureTextEntry = false
        placeholderLabel.text = nil
        containedText = ""
        errorText = "Текст ошибки"
    }
    
    private func configureTextField() {
        if let text = containedText {
            animatePlaceholderTo(topSpace: 0, fontSize: 12)
            setTextInField(text: text)
            changeAdditionalLabelHiddenState(isHidden: false)
        } else {
            animatePlaceholderTo(topSpace: 15, fontSize: 16)
        }
    }
    
    private func setTextInField(text: String) {
        if text == "" {
            containedText = nil
            animatePlaceholderTo(topSpace: 15, fontSize: 16)
        } else {
            containedText = text
        }
        textField.text = containedText
    }
    
    private func changeAdditionalLabelHiddenState(isHidden: Bool) {
        if cellModel?.additionalText != nil {
            additionalLabel.isHidden = isHidden
        } else {
            additionalLabel.isHidden = true
        }
    }
    
    private func configureAdditionalLabel() {
        if let additionalText = cellModel?.additionalText {
            let label = UILabel()
            label.numberOfLines = 1
            label.font = textField.font
            label.frame.size.height = textField.frame.height
            label.text = containedText
            label.sizeToFit()
            
            configureAdditionalLeadingConstraint(width: label.frame.width)
            additionalLabel.text = additionalText
        }
    }
    
    private func configureAdditionalLeadingConstraint(width: CGFloat) {
        let space: CGFloat = 5
        if width <= textField.frame.width + 2 {
            additionalLabelLeadingConstraint.constant = width + space
        }
    }
    
    private func configureErrorLabel() {
        if let error = errorText {
            errorLabel.text = error
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    private func configureKeyboard() {
        switch self.type {
        case .text, .code, .free:
            self.textField.keyboardType = .default
            self.textField.autocapitalizationType = .sentences
        case .accountNumber:
            self.textField.keyboardType = .numbersAndPunctuation
        case .password:
            self.textField.keyboardType = .default
        case .phoneNumber, .freeNumber, .age:
            self.textField.keyboardType = .phonePad
        case .email:
            self.textField.keyboardType = .emailAddress
        }
    }
    
}

extension TextCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? TextCellModel else { return }
        self.cellModel = cellModel
        configureWith(cellModel: cellModel)
    }
    
}

extension TextCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = containedText
        changeAdditionalLabelHiddenState(isHidden: false)
        animatePlaceholderTo(topSpace: 0, fontSize: 12)
        deleteError()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkContainedTextForVoid()
        validateContainedText()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return false }
        switch type {
        case .freeNumber:
            return checkCharacterCountAndInvalidSymbols(range: range, length: 50, text: text, string: string, charSet: .decimalDigits)
        case .phoneNumber:
            return checkCharacterCountAndInvalidSymbols(range: range, length: 11, text: text, string: string, charSet: .decimalDigits)
        case .text:
            let allowedCharacters = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")
            return checkCharacterCountAndInvalidSymbols(range: range, length: 50, text: text, string: string, charSet: allowedCharacters)
        case .accountNumber:
            return checkCharacterCountAndInvalidSymbols(range: range, length: 10, text: text, string: string, charSet: .decimalDigits)
        case .age:
            return checkCharacterCountAndInvalidSymbols(range: range, length: 2, text: text, string: string, charSet: .decimalDigits)
        case .code:
            let allowedCharacters = CharacterSet(charactersIn: "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMабвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ1234567890")
            return checkCharacterCountAndInvalidSymbols(range: range, length: 50, text: text, string: string, charSet: allowedCharacters)
        default:
            saveTextAndShiftAdditionalLabel(text: text.replacingCharacters(in: range, with: string))
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//Work with text fields

extension TextCell {
    
    private func setSecureStateForPassword(isSecure: Bool) {
        if type == .password {
            textField.isSecureTextEntry = isSecure
        }
    }
    
    private func animatePlaceholderTo(topSpace: CGFloat, fontSize: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            guard let text = self.placeholderLabel.text else { return }
            let font = UIFont.systemFont(ofSize: fontSize)
            self.placeholderLabel.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
            self.placeholderTopConstraint.constant = topSpace
        }
    }
    
    private func deleteError() {
        self.errorLabel.isHidden = true
    }
    
    private func checkContainedTextForVoid() {
        if containedText == "" || containedText == nil {
            animatePlaceholderTo(topSpace: 15, fontSize: 16)
            changeAdditionalLabelHiddenState(isHidden: true)
        }
    }
    
    private func validateContainedText() {
        if !isValidText(text: containedText) {
            setErrorState()
            validationBlock(errorLabel.text)
        } else {
            validationBlock(nil)
        }
    }
    
    private func isValidText(text: String?) -> Bool {
        guard let inputText = text else { return false }
        switch type {
        case .free:
            return Validation.validateFree(text: inputText)
        case .freeNumber:
            return Validation.validateFreeNumber(number: inputText)
        case .text, .code:
            return Validation.validateText(text: inputText)
        case .accountNumber:
            return Validation.validateAccountNumber(number: inputText)
        case .phoneNumber:
            return Validation.validatePhoneNumber(phoneNumber: inputText)
        case .email:
            return Validation.validateEmail(email: inputText)
        case .password:
            return Validation.validatePassword(password: inputText)
        case .age:
            return Validation.validateRecieptAge(age: inputText)
        }
    }
    
    private func setErrorState() {
        self.errorLabel.isHidden = false
        switch type {
        case .free, .freeNumber:
            self.errorLabel.text = ""
        case .text, .code:
            self.errorLabel.text = "Символов не может быть меньше 1 и больше 50"
        case .accountNumber:
            self.errorLabel.text = "Некорректное число"
        case .phoneNumber:
            self.errorLabel.text = "Некорректный номер телефона"
        case .email:
            self.errorLabel.text = "Некорректный email"
        case .password:
            self.errorLabel.text = "Некорректный пароль, минимум 7 символов"
        case .age:
            self.errorLabel.text = "Введите возраст. Минимум 1 символ"
        }
    }
    
    private func checkCharacterCountAndInvalidSymbols(range: NSRange, length: Int, text: NSString, string: String, charSet: CharacterSet) -> Bool {
        
        if (range.location + 1) > length {
            return false
        }
        
        var set = CharacterSet()
        for char in string {
            guard let scalar = char.unicodeScalars.first else { return false}
            set.insert(scalar)
        }
        
        if set.isStrictSubset(of: charSet) {
            saveTextAndShiftAdditionalLabel(text: text.replacingCharacters(in: range, with: string))
            return true
        }
        
        return false
    }
    
    private func saveTextAndShiftAdditionalLabel(text: String) {
        saveText(text: text)
        configureAdditionalLabel()
    }
    
    private func saveText(text: String) {
        containedText = text
        complitionBlock(containedText ?? "")
    }
    
}
