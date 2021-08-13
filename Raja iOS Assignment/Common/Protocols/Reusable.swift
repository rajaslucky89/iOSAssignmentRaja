//
//  Reusable.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import Foundation
import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? { return UINib(nibName: String(describing: self), bundle: nil) }
}
