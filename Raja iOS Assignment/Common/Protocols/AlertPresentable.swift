//
//  AlertPresentable.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

enum AlertPresentableStyle {
    case success
    case error
    case warning
}

protocol AlertPresentable where Self: UIViewController {
    func showAlert(_ message: String, alertStyle: AlertStyle)
}


extension AlertPresentable {
    
    func showAlert(_ message: String, alertStyle: AlertStyle = .success) {
        let alert = ACAlertsView(direction: .normal)
        alert.show(message, style: alertStyle)
    }
    
}

