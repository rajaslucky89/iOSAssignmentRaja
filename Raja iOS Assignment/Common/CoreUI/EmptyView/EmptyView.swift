//
//  EmptyView.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit

protocol EmptyViewDelegate: AnyObject {
    func didTapButtonAction()
}

class EmptyView: UIView {
    
    @IBOutlet public weak var contentView: UIView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var msgLabel: UILabel!
    @IBOutlet public weak var msgIcon: UIImageView!
    @IBOutlet public weak var reloadButton: UIButton!
    @IBOutlet public weak var paddingTop: NSLayoutConstraint!
    
    weak var delegate: EmptyViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        self.delegate?.didTapButtonAction()
    }
}

// MARK: - Set Components
extension EmptyView {
    func xibSetup() {
        contentView = loadNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
