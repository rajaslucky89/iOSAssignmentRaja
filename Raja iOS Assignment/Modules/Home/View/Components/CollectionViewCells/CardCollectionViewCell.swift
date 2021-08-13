//
//  CardCollectionViewCell.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import UIKit

class CardCollectionViewCell: BaseCollectionViewCell {
    // MARK: IBOutlet
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
