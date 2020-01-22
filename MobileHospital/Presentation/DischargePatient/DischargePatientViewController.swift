//
//  DischargePatientViewController.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class DischargePatientViewController: UIViewController {
    
    @IBOutlet weak var dischargePatientTableView: UITableView!
    
    lazy var presenter: DischargePatientPresenter = DischargePatientPresenter(viewState: self)
    
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
        self.dischargePatientTableView.tableFooterView = UIView()
    }
    
    func configureRespond() {
        dischargePatientTableView.delegate = self
        dischargePatientTableView.dataSource = self
    }
    
    private func registerCells() {
        DischargePatientCell.registerNib(forTableView: dischargePatientTableView)
    }
    
}

extension DischargePatientViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension DischargePatientViewController: DischargePatientView {
    
    func reloadTable() {
        self.dischargePatientTableView.reloadData()
    }
    
}
