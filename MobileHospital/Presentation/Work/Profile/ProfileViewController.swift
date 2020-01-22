//
//  ProfileViewController.swift
//  MobileHospital
//
//  Created by Даниил on 05.12.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    lazy var presenter: ProfilePresenter = ProfilePresenter(viewState: self)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        configureTableView()
        configureRespond()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.refresh()
    }
    
    private func configureTableView() {
        if #available(iOS 10.0, *) {
            profileTableView.refreshControl = refreshControl
        } else {
            profileTableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.profileTableView.tableFooterView = UIView()
    }
    
    @objc private func refreshData(_ sender: Any) {
        presenter.refresh()
    }
    
    func configureRespond() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    private func registerCells() {
        SingleInfoCell.registerNib(forTableView: profileTableView)
        PhotoCell.registerNib(forTableView: profileTableView)
        NSPACell.registerNib(forTableView: profileTableView)
        ActionCell.registerNib(forTableView: profileTableView)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension ProfileViewController: ProfileView {
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.profileTableView.reloadData()
        }
    }
    
    func showLoader() {
        Events.ShowLoader.post()
    }
    
    func hideLoader() {
        Events.HideLoader.post()
    }
    
}
