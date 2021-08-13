//
//  BaseView.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit
import RxSwift

open class BaseView: UIViewController, UIGestureRecognizerDelegate {
    
    open var disposeBag = DisposeBag()
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                if #available(iOS 13.0, *) {
                    return .darkContent
                } else {
                    return .default
                }
            } else {
                return .lightContent
            }
        } else {
            return .default
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Enable swipe gesture back
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func addNavigationTitle(_ title: String, textColor: UIColor = UIColor.white, textSize: CGFloat = 16, alpha: CGFloat = 1.0) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = title
        titleLabel.textColor = textColor.withAlphaComponent(alpha)
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        navigationItem.titleView = titleLabel
    }
    
    internal func setNavigationBar (
        barTintColor: UIColor = .white,
        imgArrow: UIImage? = UIImage(named: "iconBack"),
        forModal: Bool = false,
        isTransparent: Bool = false) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 8, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFill
        
        if forModal {
            imageView.image = #imageLiteral(resourceName: "iconBack")
            let backTap = UITapGestureRecognizer(target: self, action: #selector(didTapDismissGesture(_:)))
            view.addGestureRecognizer(backTap)
        } else {
            imageView.image = imgArrow
            let backTap = UITapGestureRecognizer(target: self, action: #selector(didTapBackGesture(_:)))
            view.addGestureRecognizer(backTap)
        }
        
        view.addSubview(imageView)
        
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if isTransparent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.isTranslucent = true
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.tintColor = barTintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
    }
    
    
    @objc func didTapBackGesture(_ tapGesture: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDismissGesture(_ tapGesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

