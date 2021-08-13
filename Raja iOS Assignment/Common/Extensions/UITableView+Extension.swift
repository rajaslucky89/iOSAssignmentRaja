//
//  UITableView+Extension.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import Foundation
import UIKit


public extension UITableView {
    internal func setEmptyView(title: String, msg: String?, icon: UIImage? = nil, titleButton: String? = nil, paddingTop: CGFloat? = -40, delegate: EmptyViewDelegate? = nil) {
        
        if titleButton == nil {
            let emptyView = EmptyResultViewBuilder()
                .setEmpty(title, msg: msg, icon: icon, paddingTop: paddingTop)
                .build()
            self.backgroundView = emptyView
        } else {
            let emptyView = EmptyResultViewBuilder()
                .setEmpty(title, msg: msg, icon: icon, paddingTop: paddingTop)
                .setButtonTitle(titleButton, delegate: delegate)
                .build()
            self.backgroundView = emptyView
        }
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    func dequeueReusableCell<T: Reusable>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
    
    func reloadDataWithoutAnimation() {
        let cachedOffset = contentOffset
        reloadData()
        layer.removeAllAnimations()
        setContentOffset(cachedOffset, animated: false)
    }
    
}
