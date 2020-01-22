//
//  PatientsViewController.swift
//  MobileHospital
//
//  Created by Даниил on 05.12.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class PatientsViewController: UIViewController {
    
    @IBOutlet weak var patientsTableView: UITableView!
    
    lazy var presenter: PatientsPresenter = PatientsPresenter(viewState: self)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        configureTableView()
        configureRespond()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewDidLoad()
        configureBarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    private func configureTableView() {
        if #available(iOS 10.0, *) {
            refreshControl.alpha = 0
            patientsTableView.refreshControl = refreshControl
        } else {
            patientsTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.patientsTableView.tableFooterView = UIView()
    }
    
    @objc private func refreshData(_ sender: Any) {
        refreshControl.endRefreshing()
        presenter.refresh()
    }
    
    func configureRespond() {
        patientsTableView.delegate = self
        patientsTableView.dataSource = self
    }
    
    private func registerCells() {
        PatientCell.registerNib(forTableView: patientsTableView)
    }
    
    private func configureBarButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHandler))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addHandler() {
        presenter.toAddPatient()
    }
    
}

extension PatientsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        presenter.toSinglePatient(index: indexPath.row)
    }
    
}

extension PatientsViewController: PatientsView {
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.patientsTableView.reloadData()
        }
    }
    
}
