//
//  DynamicList.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import Foundation
import UIKit

class AutomaticTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
}

class AutoMaticHeightCollectionView: UICollectionView {
  var isDynamicSizeRequired = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
      
      if self.intrinsicContentSize.height > frame.size.height {
        self.invalidateIntrinsicContentSize()
      }
      if isDynamicSizeRequired {
        self.invalidateIntrinsicContentSize()
      }
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return contentSize
  }

}
