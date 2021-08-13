//
//  UISearchBar+Extension.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}

class SearchBarView: UIView {
    let searchBar: UISearchBar
    
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        addSubview(searchBar)
        setupSearchBar()
    }
    
    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
    func setupSearchBar() {
        searchBar.backgroundColor = .clear
        changeBackgroundColor(color: BaseColor.borderColor)
    }
    
    func changeBackgroundColor(color: UIColor) {
        // change textfield background color on searchbar
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = color
        } else {
            // Fallback on earlier versions
            let searchTextField = searchBar.value(forKey: "_searchField") as? UITextField
            searchTextField?.backgroundColor = color
        }
        
        // remove black background color
        for subView in searchBar.subviews {
            for view in subView.subviews {
                if view.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                    let imageView = view as! UIImageView
                    imageView.removeFromSuperview()
                }
            }
        }
    }
    
}
