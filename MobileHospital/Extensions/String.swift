//
//  String.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

extension String {
    
    func determineTheLastDigitOfAge() -> String {
        guard let lastDigitChar = self.last else { return "лет" }
        let lastDigit = "\(lastDigitChar)"
        switch lastDigit {
        case "0", "5", "6", "7", "8", "9":
            return "лет"
        case "1":
            return "год"
        case "2", "3", "4":
            return "года"
        default:
            return "лет"
        }
    }
    
    func convertStringToDate(withFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    func convertStringWithNormalFormatToDate() -> Date {
        return convertStringToDate(withFormat: "dd.MM.yyyy")
    }
    
    func convertStringWithProtekFormatToDate() -> Date {
        return convertStringToDate(withFormat: "yyyy-MM-dd")
    }
    
}
