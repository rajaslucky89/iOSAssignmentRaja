//
//  ImagePreviewCoordinator.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import RxSwift

class ImagePreviewCoordinator: BaseCoordinator<Void> {
    
    // MARK: Variables
    private let rootViewController: UIViewController
    private var viewModel = CardDetailViewModel()
    var photos: UnsplashPhotos!
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = ImagePreviewViewController()
        viewController.viewModel = viewModel
        viewController.viewModel.photos.accept(photos)
        rootViewController.navigationController?.present(viewController, animated: true, completion: nil)
        
        return Observable.never()
    }
    
}
