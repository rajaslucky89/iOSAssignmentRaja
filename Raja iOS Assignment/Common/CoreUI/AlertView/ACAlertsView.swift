//
//  ACAlertsView.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

class ACAlertsView: UIView {
    
    public var marginBottom: CGFloat = 100
    public var duration = 0.3
    public var delay: Double = 2.0
    public var direction = AnimationDirection.normal
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @IBOutlet weak var alertContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertIcon: UIImageView!
    @IBOutlet weak var alertBorder: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        // add shadow to container
        self.alertContainer.addShadow(offset: CGSize(width: 0, height: 2), color: UIColor.grayShadow, borderColor: UIColor.grayShadow, radius: 2, opacity: 0.8)
        
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "ACAlertsView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    public init(direction: AnimationDirection = .normal, marginBottom: CGFloat = 100) {
        super.init(frame: CGRect.zero)
        commonInit()
        self.marginBottom = marginBottom
        self.frame = getFrameBy(direction: direction)
        self.direction = direction
    }
    
    public func show(_ message: String, style: AlertStyle, font: UIFont = UIFont.systemFont(ofSize: 16), direction: AnimationDirection = .toRight, delay: Double = 2.0) {
        
        addWindowSubview(self)
        configureProperties(message, style: style)
        
        self.delay = delay
        
        UIView.animate(withDuration: self.duration, animations: {
            
            switch self.direction {
            case .toRight:
                self.frame.origin.x = 0
            case .toLeft:
                self.frame.origin.x = 0
            case .normal:
                self.frame.origin.y = self.screenHeight-self.marginBottom
            }
        })
        perform(#selector(hide), with: self, afterDelay: self.delay)
    }
    
    @objc private func hide(_ alertView: UIButton) {
        
        UIView.animate(withDuration: duration, animations: {
            
            switch self.direction {
            case .toRight:
                self.frame.origin.x = -self.screenWidth
            case .toLeft:
                self.frame.origin.x = self.screenWidth
            case .normal: (alertView.frame.origin.y = self.screenHeight)
            }
        })
        
        perform(#selector(remove), with: alertView, afterDelay: delay)
    }
    
    
    @objc private func remove(_ alertView: UIButton) {
        alertView.removeFromSuperview()
    }
    
    private func configureProperties(_ message: String, style: AlertStyle) {
        
        self.titleLabel.text = message
        
        switch style {
        case .success:
            self.alertContainer.backgroundColor = .greenIce
            self.alertBorder.backgroundColor = .lightGreen
            self.alertIcon.image = UIImage(named: "success_icon")
        case .error:
            self.alertContainer.backgroundColor = .lightPink
            self.alertBorder.backgroundColor = .redCoral
            self.alertIcon.image = UIImage(named: "error_icon")
        case .info:
            self.alertContainer.backgroundColor = .icedBlue
            self.alertBorder.backgroundColor = .darkBlue
            self.alertIcon.image = UIImage(named: "info_icon")
        case .warning:
            self.alertContainer.backgroundColor = .icedBlue
            self.alertBorder.backgroundColor = .goldenYellow
            self.alertIcon.image = UIImage(named: "warning_icon")
        }
        
    }
    
    // MARK: -- FRAME SETUP
    private func getFrameBy(direction: AnimationDirection) -> CGRect {
        return getFrameOfBottomPositionBy(direction)
    }
    
    private func getFrameOfBottomPositionBy(_ direction: AnimationDirection) -> CGRect {
        let frame: CGRect
        switch direction {
        case .toRight:
            frame = CGRect(x: -screenWidth, y: screenHeight - marginBottom, width: screenWidth, height: marginBottom)
        case .toLeft:
            frame = CGRect(x: screenWidth, y: screenHeight - marginBottom, width: screenWidth, height: marginBottom)
        case .normal:
            frame = CGRect(x: 0.0, y: screenHeight + marginBottom, width: screenWidth, height: marginBottom)
        }
        return frame
    }
    
    
}
