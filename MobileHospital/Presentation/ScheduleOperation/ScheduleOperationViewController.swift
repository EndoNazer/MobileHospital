//
//  ScheduleOperationViewController.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class ScheduleOperationViewController: UIViewController {
    
    @IBOutlet weak var scheduleOperationTableView: UITableView!
    
    lazy var presenter: ScheduleOperationPresenter = ScheduleOperationPresenter(viewState: self)
    
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
        self.scheduleOperationTableView.tableFooterView = UIView()
    }
    
    func configureRespond() {
        scheduleOperationTableView.delegate = self
        scheduleOperationTableView.dataSource = self
    }
    
    private func registerCells() {
        ScheduleOperationCell.registerNib(forTableView: scheduleOperationTableView)
    }
    
}

extension ScheduleOperationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountCellModels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter.cellModels[indexPath.row] as? TableCellModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseIdentifier, for: indexPath) as? TableCell else {
                return UITableViewCell()
        }
        cell.config(cellModel: model)
        
        if let cell = cell as? ScheduleOperationCell {
            cell.datePickerAction = { [weak self] in
                guard let `self` = self else {return}
                let vc = DatePickerViewController()
                vc.delegate = self
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        return cell
    }
    
}

extension ScheduleOperationViewController: ScheduleOperationView {

    func reloadTable() {
        self.scheduleOperationTableView.reloadData()
    }
    
    func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - DatePickerDelegate

extension ScheduleOperationViewController: DatePickerViewControllerDelegate {
    func acceptButtonPressed(date: Date) {
        presenter.date = date.convertDateToNormalDateString()
        self.reloadTable()
    }
    
}
