//
//  UITableViewProtocols.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func registerNib(forTableView tableView: UITableView) {
        let placeHolderNib = UINib.init(nibName: self.reuseIdentifier, bundle: nil)
        tableView.register(placeHolderNib, forCellReuseIdentifier: self.reuseIdentifier)
    }
}

typealias TableCell = UITableViewCell & TableCellConfigurable

protocol TableCellModel {
    var reuseIdentifier: String { get }
}

protocol TableCellConfigurable {
    func config(cellModel: TableCellModel)
}
