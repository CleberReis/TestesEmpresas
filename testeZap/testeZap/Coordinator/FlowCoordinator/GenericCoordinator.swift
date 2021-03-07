//
//  ZapCoordinator.swift
//  testeZap
//
//  Created by Cleber Reis on 23/02/21.
//

import UIKit

protocol GenericFlowCoordinator {
    func goToDetail(residence: ResidenceModel)
}

class GenericCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var childCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){}
    
    func startZap() {
        let zapViewController = ZapViewController()
        zapViewController.coordinator = self
        navigationController.pushViewController(zapViewController, animated: true)
    }
    
    func startVivaReal() {
        let vivaRealViewController = VivaRealViewController()
        vivaRealViewController.coordinator = self
        navigationController.pushViewController(vivaRealViewController, animated: true)
    }

}

extension GenericCoordinator: GenericFlowCoordinator {
    func goToDetail(residence: ResidenceModel) {
        let detailViewController = ResidenceDetailsViewController()
        detailViewController.residenceDetail = residence
        navigationController.present(detailViewController, animated: true, completion: nil)
    }
}
