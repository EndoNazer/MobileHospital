//
//  GlobalRouter.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import Foundation
import UIKit

protocol GlobalRouterInput { 
}

class GlobalRouter: GlobalRouterInput {
    private var transitionHandler: UIViewController!
    
    init(withTransitionHandler transitionHandler: UIViewController) {
        self.transitionHandler = transitionHandler
    }
}
