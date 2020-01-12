//
//  BaseInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class BaseInteractor: UseCase<Void> { //<T: BaseModel>: UseCase<T> {
    var jobs : [Job] = []

    func destroy() {
        for job in jobs {
            job.cancel()
        }
    }
    
    deinit {
        destroy()
    }
    
}
