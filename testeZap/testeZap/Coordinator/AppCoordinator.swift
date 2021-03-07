//
//  AppCoordinator.swift
//  testeZap
//
//  Created by Cleber Reis on 23/02/21.
//

import UIKit

class AppCoordinator: Coordinator {

    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
}

extension AppCoordinator {
    
    func start() {
        startTabView()
    }
    
    private func startTabView() {
        let tabBar = TabBarController()
        
        let vivaReal = createNavigationController(image: "logoVivaReal", title: "Viva Real", tag: 0)
        let vivaRealCoordinator = GenericCoordinator(navigationController: vivaReal)
        
        let zap = createNavigationController(image: "logoZap", title: "Grupo Zap", tag: 1)
        let zapCoordinator = GenericCoordinator(navigationController: zap)
        
        tabBar.viewControllers = [vivaReal, zap]
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        vivaRealCoordinator.startVivaReal()
        zapCoordinator.startZap()
    }
    
    private func createNavigationController(image: String, title: String, tag: Int) -> UINavigationController {
        
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image), selectedImage: UIImage(named: image))
        navigationController.tabBarItem.tag = tag
        
        return navigationController
    }
    
}
