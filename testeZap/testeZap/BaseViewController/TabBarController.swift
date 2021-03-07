//
//  TabBarController.swift
//  testeZap
//
//  Created by Cleber Reis on 23/02/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .lightGray
        
    }
    
}
