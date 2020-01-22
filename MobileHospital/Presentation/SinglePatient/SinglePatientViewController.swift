//
//  SinglePatientViewController.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class SinglePatientViewController: UIViewController {
    
    @IBOutlet weak var singlePatientTableView: UITableView!
    
    lazy var presenter: SinglePatientPresenter = SinglePatientPresenter(viewState: self)
    //private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureRespond()
        registerCells()
        setBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewDidLoad()
        self.presenter.refresh()
    }
    
    private func configureTableView() {
//        if #available(iOS 10.0, *) {
//            refreshControl.alpha = 0
//            patientsTableView.refreshControl = refreshControl
//        } else {
//            patientsTableView.addSubview(refreshControl)
//        }
//
//        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.singlePatientTableView.tableFooterView = UIView()
    }
    
//    @objc private func refreshData(_ sender: Any) {
//        refreshControl.endRefreshing()
//        presenter.refresh()
//    }
    
    func configureRespond() {
        singlePatientTableView.delegate = self
        singlePatientTableView.dataSource = self
    }
    
    private func registerCells() {
        SingleInfoCell.registerNib(forTableView: singlePatientTableView)
        PatientCell.registerNib(forTableView: singlePatientTableView)
        PhotoCell.registerNib(forTableView: singlePatientTableView)
        NSPACell.registerNib(forTableView: singlePatientTableView)
        ActionCell.registerNib(forTableView: singlePatientTableView)
        SinglePatientInfoCell.registerNib(forTableView: singlePatientTableView)
    }
    
}

extension SinglePatientViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension SinglePatientViewController: SinglePatientView {
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.singlePatientTableView.reloadData()
        }
    }
    
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
