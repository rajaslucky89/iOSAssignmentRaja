//
//  ImagePreviewViewController.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import UIKit

class ImagePreviewViewController: BaseView {
    // MARK: IBOutlet
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Variables
    var viewModel: CardDetailViewModel!
    var tap: UITapGestureRecognizer!
    
    init() { super.init(nibName: "ImagePreviewViewController", bundle: nil) }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setupComponent()
        populateData()
    }
    
    func setNavigation() {
        setNavigationBar(barTintColor: #colorLiteral(red: 0, green: 0.672973454, blue: 0.7734043002, alpha: 1), imgArrow: #imageLiteral(resourceName: "iconBack"), forModal: true)
        addNavigationTitle("Image Preview", textSize: 16.0)
    }
    
    func setupComponent() {
        self.scrollview.minimumZoomScale = 1
        self.scrollview.maximumZoomScale = 3.5
        self.scrollview.delegate = self
        self.tap = UITapGestureRecognizer(target: self, action: #selector(resetZoom))
        self.tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(self.tap)
    }
    
    func populateData() {
        imageView.setImageFromNetwork(url: viewModel.photos.value?.urls?.full ?? "")
    }
    
    @objc func resetZoom() {
        self.scrollview.zoomScale = 1
    }
}

// MARK: UIScrollViewDelegate
extension ImagePreviewViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
