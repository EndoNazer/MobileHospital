//
//  Array.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

extension Array where Element: Job {
    static func += (_ array: inout Array, _ job: Element) {
        array.append(job)
    }
}

extension Array where Element == String {
    mutating func appendIfNotExist(_ element: Element) {
        if !self.contains(where: { (el) -> Bool in
            return el == element
        }) {
            append(element)
        }
    }
}
