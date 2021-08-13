//
//  AppDelegate.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import Wormholy

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        // Network Debugging
        #if DEBUG
        Wormholy.limit = 20
        _ = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { total in
                    //Logger.log("MEMORY RESOURCE => \(RxSwift.Resources.total)")
                }
            )
        #endif
        
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        return true
    }
}

// MARK: Private
private extension AppDelegate {
    func resetState() {
        let defaultsName = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: defaultsName)
    }
}

// MARK: - Memory Used Tracking
#if TRACE_RESOURCES
private var resourceCount: AtomicInt = 0

public struct Resources {
    public static var total: Int32 {
        return resourceCount.valueSnapshot()
    }
}
#endif
