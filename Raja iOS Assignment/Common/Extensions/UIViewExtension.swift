//
//  UIViewExtension.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

extension UIView {
    static var nibName: String {
        return self.description().components(separatedBy: ".").last ?? ""
    }
    
    static var identifier: String {
        return self.nibName
    }
    
    func roundedView() {
        self.clipsToBounds = false
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(white: 0.8, alpha: 1).cgColor
    }
    
    func squareRoundedView() {
        self.clipsToBounds = false
        self.layer.cornerRadius = 5
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            if #available(iOS 11.0, *) {
                self.clipsToBounds = true
                self.layer.cornerRadius = radius
                self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            } else {
                let path = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
                self.layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor, borderColor: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.borderColor = borderColor.cgColor
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.shadowColor!)
            return color
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
}

extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: self.classForCoder), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func createFromNib<T: UIView>(_ type: T.Type) -> T {
        let view = T.nib().instantiate(
            withOwner: nil,
            options: nil).first as! T
        return view
    }
}
