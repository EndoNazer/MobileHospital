//
//  AddPatientView.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

protocol AddPatientView: BaseView {
    func reloadTable()
    func popBack()
}
