//
//  UIViewController+Extensions.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

// MARK: viewcontroler extension
extension UIViewController {
    
    func showModal(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}
