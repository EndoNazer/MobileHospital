//
//  SelectDrugViewController.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SelectDrugViewController: UIViewController {
    
    @IBOutlet weak var selectDrugTableView: UITableView!
    
    lazy var presenter: SelectDrugPresenter = SelectDrugPresenter(viewState: self)
    
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
        self.selectDrugTableView.tableFooterView = UIView()
    }
    
    func configureRespond() {
        selectDrugTableView.delegate = self
        selectDrugTableView.dataSource = self
    }
    
    private func registerCells() {
        SelectDrugCell.registerNib(forTableView: selectDrugTableView)
    }
    
}

extension SelectDrugViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.addDrugToPatient(index: indexPath.row)
    }
    
}

extension SelectDrugViewController: SelectDrugView {
    
    func reloadTable() {
        self.selectDrugTableView.reloadData()
    }
    
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
