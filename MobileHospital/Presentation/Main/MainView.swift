//
//  NavigationView.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit

protocol MainView: BaseView {
    func showMessage(_ message: String)
    func showLoader()
    func hideLoader()
}
