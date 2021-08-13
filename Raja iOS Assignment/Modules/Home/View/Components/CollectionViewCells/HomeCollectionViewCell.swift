//
//  HomeCollectionViewCell.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 07/08/21.
//

import UIKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var photoData: UnsplashPhotos? {
        didSet {
            guard let data = photoData else { return }
            nameLabel.text = data.user?.name
            descriptionLabel.text = data.description
            imageView.setImageFromNetwork(url: data.urls?.small ?? "")
        }
    }
    
    override func layoutSubviews() {
        imageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderColor = BaseColor.borderColor.cgColor
        containerView.layer.borderWidth = 0.4
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        layer.cornerRadius = 8
        clipsToBounds = true
        
        containerView.addShadow(offset: CGSize(width: 0, height: 2), color: UIColor.black.withAlphaComponent(0.6), borderColor: BaseColor.borderColor, radius: 2, opacity: 0.6)
    
    }

}
