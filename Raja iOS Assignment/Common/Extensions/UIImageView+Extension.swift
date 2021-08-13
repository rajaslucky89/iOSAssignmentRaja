//
//  UIImageView+Extension.swift
//
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromNetwork(url: String) {
        let checkSpace = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        self.kf.setImage(with: URL(string: checkSpace), placeholder: UIImage(named: "placeHolder"), options: [.cacheMemoryOnly, .transition(.fade(0.5))])
    }
}
