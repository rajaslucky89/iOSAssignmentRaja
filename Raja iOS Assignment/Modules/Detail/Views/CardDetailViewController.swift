//
//  ArticleDetailViewController.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit
import RxGesture

final class CardDetailViewController: BaseView {
    
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Variable
    var viewModel: CardDetailViewModel!
    
    init() { super.init(nibName: "CardDetailViewController", bundle: nil) }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setupComponent()
        bindViewModel()
        populateData()
    }
    
    func bindViewModel () {
        viewModel.state
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .loading:
                    self.containerView.showAnimatedGradientSkeleton()
                case .finish, .error:
                    self.containerView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
                default: break
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: Private
private extension CardDetailViewController {
    func setNavigation() {
        setNavigationBar(barTintColor: #colorLiteral(red: 0, green: 0.672973454, blue: 0.7734043002, alpha: 1), imgArrow: #imageLiteral(resourceName: "iconBack"), forModal: false)
        addNavigationTitle(viewModel.photos.value?.user?.name ?? "Photo Detail", textSize: 16.0)
    }
    
    func setupComponent() {
        containerView.layer.cornerRadius = 8
        containerView.addShadow(offset: CGSize(width: 1, height: 2), color: BaseColor.borderColor, borderColor: BaseColor.borderColor, radius: 8, opacity: 0.9)
        imageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 8)
        imageView.isUserInteractionEnabled = true
        imageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [unowned self] _ in
                if let photo = self.viewModel.photos.value {
                    self.viewModel.didTapImage.onNext(photo)
                }
            }).disposed(by: disposeBag)
    }
    
    func populateData() {
        nameLabel.text = viewModel.photos.value?.user?.name
        descriptionLabel.text = viewModel.photos.value?.description
        imageView.setImageFromNetwork(url: viewModel.photos.value?.urls?.full ?? "")
    }
}
