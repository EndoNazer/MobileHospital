//
//  Validation.swift
//  MobileHospital
//
//  Created by Даниил on 19.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

class Validation {
    
    static func validateFree(text: String) -> Bool {
        return true
    }
    static func validateFreeNumber(number: String) -> Bool {
        let numberRegex = "[0-9]{0,50}$"
        let trimmedString = number.trimmingCharacters(in: .whitespaces)
        let validateNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        let isValidNumber = validateNumber.evaluate(with: trimmedString)
        return isValidNumber
    }
    static func validateText(text: String) -> Bool {
        // Length be 50 characters max and 2 characters minimum, you can always modify.
        let textRegex = "^.{0,50}$"
        let trimmedString = text.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", textRegex)
        let isValidateText = validateName.evaluate(with: trimmedString)
        return isValidateText
    }
    static func validateAccountNumber(number: String) -> Bool {
        let numberRegex = "[0-9]{0,10}$"
        let trimmedString = number.trimmingCharacters(in: .whitespaces)
        let validateNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        let isValidNumber = validateNumber.evaluate(with: trimmedString)
        return isValidNumber
    }
    static func validatePhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "[0-9]{11}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    static func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = email.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    static func validatePassword(password: String) -> Bool {
        //Minimum 7 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^.{7,}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
        return true
    }
    static func validateRecieptAge(age: String) -> Bool {
        let recieptTimeRegex = "[0-9]{1,2}$"
        let trimmedString = age.trimmingCharacters(in: .whitespaces)
        let validateTime = NSPredicate(format: "SELF MATCHES %@", recieptTimeRegex)
        let isValidTime = validateTime.evaluate(with: trimmedString)
        return isValidTime
    }
    
}
