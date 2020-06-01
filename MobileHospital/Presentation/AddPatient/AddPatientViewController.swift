//
//  AddPatientViewController.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class AddPatientViewController: UIViewController {
    
    @IBOutlet weak var addPatientTableView: UITableView!
    
    lazy var presenter: AddPatientPresenter = AddPatientPresenter(viewState: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        configureTableView()
        configureRespond()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewDidLoad()
    }
    
    private func configureTableView() {
        self.addPatientTableView.tableFooterView = UIView()
    }
    
    func configureRespond() {
        addPatientTableView.delegate = self
        addPatientTableView.dataSource = self
    }
    
    private func registerCells() {
        TextCell.registerNib(forTableView: addPatientTableView)
        ActionCell.registerNib(forTableView: addPatientTableView)
    }
    
}

extension AddPatientViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.configureCellModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter.configureCellModels()[indexPath.row] as? TableCellModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath) as? TableCell else {
                return UITableViewCell()
        }
        cell.config(cellModel: model)
        return cell
    }
    
}

extension AddPatientViewController: AddPatientView {
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.addPatientTableView.reloadData()
        }
    }
    
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
