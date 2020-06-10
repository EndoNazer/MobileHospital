//
//  DocumentsViewController.swift
//  MobileHospital
//
//  Created by Даниил on 05.12.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {
    
    @IBOutlet weak var documentsTableView: UITableView!
    
    lazy var presenter: DocumentsPresenter = DocumentsPresenter(viewState: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        configureTableView()
        configureRespond()
        registerCells()
    }
    
    private func configureTableView() {
        self.documentsTableView.tableFooterView = UIView()
    }
    
    func configureRespond() {
        documentsTableView.delegate = self
        documentsTableView.dataSource = self
    }
    
    private func registerCells() {
        ActionCell.registerNib(forTableView: documentsTableView)
    }
    
}

extension DocumentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountCellModels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter.cellModels[indexPath.row] as? TableCellModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath) as? TableCell else {
                return UITableViewCell()
        }
        cell.config(cellModel: model)
        return cell
    }
    
}

extension DocumentsViewController: DocumentsView {
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.documentsTableView.reloadData()
        }
    }
    
}
