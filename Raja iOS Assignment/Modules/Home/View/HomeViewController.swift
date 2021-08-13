//
//  HistoryPointViewController.swift
//  tenantapp
//
//  Created by Raja Syahmudin on 23/07/21.
//  Copyright © 2021 RoomMe. All rights reserved.
//

import UIKit

class HistoryPointViewController: BaseViewController {
    // MARK: IBOutlet
    @IBOutlet weak var tableView: AutomaticTableView!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var totalRoomMePointLabel: UILabel!
    @IBOutlet weak var totalRoomMePointSpentLabel: UILabel!
    
    // MARK: Variable
    var viewModel = LoyaltyPointsViewModel()
    var history = BehaviorRelay<[LoyaltyPointsHistory]>(value: [])
    
    init() {
        super.init(nibName: "HistoryPointViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setComponents()
        populateData()
        setupTableView()
    }
    
    func populateData() {
        totalRoomMePointLabel.text = Converter.thousandSeparatorConverter(Int(viewModel.loyaltyData?.roommePoint ?? "0") ?? 0)
        totalRoomMePointSpentLabel.text = Converter.thousandSeparatorConverter(Int(viewModel.loyaltyData?.roommePointSpent ?? "0") ?? 0)
        if viewModel.historyPointData?.count == 0 {
            self.emptyView.isHidden = false
        } else {
            self.emptyView.isHidden = true
        }
        
        self.history.bind(to: self.tableView.rx.items(cellIdentifier: HistoryPointTableViewCell.reuseIdentifier, cellType: HistoryPointTableViewCell.self)) { index, data, cell in
            cell.historyData = data
        }.disposed(by: disposeBag)
        
    }
    
}

// MARK: Private
private extension HistoryPointViewController {
    func setComponents() {
        emptyView.layer.cornerRadius = 8
        emptyView.addShadow(offset: CGSize(width: 1, height: 2), color: UIColor.borderColor, borderColor: UIColor.borderColor, radius: 8, opacity: 0.8)
    }
    
    func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(HistoryPointTableViewCell.self)
        tableView.reloadData()
    }
    
    func setupNavigation() {
        navigationView.backButton.addTarget(self, action: #selector(popViewController(_:)), for: .touchUpInside)
        navigationView.titleLabel.text = "History"
    }
    
    @objc func popViewController(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
