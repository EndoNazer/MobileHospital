//
//  Date.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

extension Date {
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    func convertDateToString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func convertDateToNormalDateString() -> String {
        return convertDateToString(withFormat: "dd.MM.yyyy")
    }
    
    func convertDateToProtekDateString() -> String {
        return convertDateToString(withFormat: "yyyy-MM-dd")
    }
    
    func days(to secondDate: Date, calendar: Calendar = Calendar.current) -> Int {
        let day = calendar.dateComponents([.day], from: self, to: secondDate).day!
        return day
    }
    
}
