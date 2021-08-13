//
//  ACAlerts+Extensions.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import Foundation
import UIKit

extension UIView {
    
    func addWindowSubview(_ view: UIView) {
        if self.superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal
                    && !window.isHidden
                    && window.frame != CGRect.zero {
                    window.addSubview(view)
                    return
                }
            }
        }
    }
    
}


extension UIColor {
    
    public static var lightRed: UIColor {
        return UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 0.9)
    }
    
    public static var greenIce: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 1.0, blue: 249.0 / 255.0, alpha: 1.0)
    }
    
    public static var lightGreen: UIColor {
        return UIColor(red: 71.0 / 255.0, green: 215.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    
    public static var lightPink: UIColor {
        return UIColor(red: 1.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    public static var redCoral: UIColor {
        return UIColor(red: 244.0 / 255.0, green: 84.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
    
    public static var icedBlue: UIColor {
        return UIColor(red: 244.0 / 255.0, green: 249.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    public static var darkBlue: UIColor {
        return UIColor(red: 47.0 / 255.0, green: 134.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    }
    
    public static var goldenYellow: UIColor {
        return UIColor(red: 1.0, green: 192.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }
    
    public static var grayShadow: UIColor {
        return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    }
    
}
