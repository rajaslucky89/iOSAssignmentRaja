//
//  UICollectionView+Extension.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import Foundation
import UIKit

public extension UICollectionView {
    enum SupplementaryViewKind {
        case header
        case footer
        
        var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
}

public extension UICollectionView {
    func dequeueReusableCell<T: Reusable>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionReusableView>(view: T.Type, asSupplementaryViewKind kind: SupplementaryViewKind) where T: Reusable {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: SupplementaryViewKind, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
    
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
    
}
