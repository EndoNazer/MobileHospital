//
//  SinglePatientInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SinglePatientInteractor: BaseInteractor {
    
    func getImage(image: String, complition: @escaping ((UIImage) -> Void)) {
        Events.ShowLoader.post()
        UIImage().downloaded(from: image, complition: { (img) in
            complition(img)
            Events.HideLoader.post()
        }) {
            Events.HideLoader.post()
        }
    }
    
}
