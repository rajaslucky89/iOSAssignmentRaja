//
//  EmptyResultView.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import Foundation
import UIKit

class EmptyResultViewBuilder {
    
    private var emptyView = EmptyView()
    
    @discardableResult
    func setEmpty(_ title: String?, msg: String?, icon: UIImage? = nil, paddingTop: CGFloat? = nil) -> EmptyResultViewBuilder {
        emptyView.titleLabel.text = title
        emptyView.msgLabel.text = msg
        emptyView.paddingTop.constant = paddingTop ?? -40.0
        if icon != nil {
            emptyView.msgIcon.image = icon
        }
        return self
    }
    
    @discardableResult
    func setButtonTitle(_ buttonTitle: String?, delegate: EmptyViewDelegate?) -> EmptyResultViewBuilder {
        emptyView.reloadButton.isHidden = false
        emptyView.reloadButton.setTitle(buttonTitle, for: .normal)
        emptyView.delegate = delegate
        return self
    }
    
    func build() -> EmptyView {
        return emptyView
    }
    
}
