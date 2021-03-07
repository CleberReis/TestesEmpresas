//
//  ZapViewController.swift
//  testeZap
//
//  Created by Cleber Reis on 23/02/21.
//

import UIKit

class ZapViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
            self.tableView.refreshControl = refreshControl
        }
    }
    
    // MARK: - Properties
    var waiter: ResidenceWaiter = ResidenceWaiter()
    private var residences: [ResidenceModel]?
    private let cell = String(describing: GenericTableViewCell.self)
    let refreshControl = UIRefreshControl()
    var coordinator: GenericFlowCoordinator?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .allEvents)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        waiter.orderReady = self
        waiter.bringMeResidencesForMe(type: .zap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Methods
    @objc private func pullToRefresh() {
        waiter.refreshResidenceForMe(type: .zap)
    }

    
}

// MARK: - Extension
extension ZapViewController: ResidenceOrderReady {
    
    func hereAreYourResidences(residences: [ResidenceModel]) {
        
        DispatchQueue.main.async {
            self.residences = residences
            self.title = "Zap"
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    
    }
    
    func errorWithYourResidences() {
        print("errorWithYourResidences")
    }
    
    func residencesAreEmpty() {
        print("residencesAreEmpty")
    }
    
}

extension ZapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = residences?[indexPath.row] {
            coordinator?.goToDetail(residence: item)
        }
    }
}

extension ZapViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.residences?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? GenericTableViewCell else {
            return UITableViewCell()
        }
        
        if let item = self.residences?[indexPath.row] {
            cell.setupCell(residenceModel: item)
        }
        
        return cell
    }
    
}
