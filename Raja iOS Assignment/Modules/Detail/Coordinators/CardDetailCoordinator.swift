//
//  CardDetailCoordinator.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift

class CardDetailCoordinator: BaseCoordinator<Void> {
    
    // MARK: Variables
    private let rootViewController: UIViewController
    private var viewModel = CardDetailViewModel()
    var photos: UnsplashPhotos!
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = CardDetailViewController()
        viewController.viewModel = viewModel
        viewController.viewModel.photos.accept(photos)
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        
        viewModel.didTapImage
            .flatMap( { [unowned self] (data) in
                return self.coordinateToImagePreview(with: data)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    private func coordinateToImagePreview(with data: UnsplashPhotos) -> Observable<Void> {
        let coordinator = ImagePreviewCoordinator(rootViewController: rootViewController)
        coordinator.photos = data
        return coordinate(to: coordinator)
            .map { _ in () }
    }
}
