//
//  AppCoordinator.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let navigationController = UINavigationController(rootViewController: HomeView())
        let coordinator = HomeViewCoordinator(rootViewController: navigationController.viewControllers[0])
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: coordinator)
    }
}
