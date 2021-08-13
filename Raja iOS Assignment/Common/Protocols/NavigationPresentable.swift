//
//  NavigationPresentable.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

protocol NavigationPresentable where Self: UIViewController {
    func dismissFadeIn()
    func presentFadeIn(_ viewController: UIViewController)
}


extension NavigationPresentable {
    
    func dismissFadeIn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    func presentFadeIn(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        self.present(viewController, animated: true, completion: nil)
    }
    
}
