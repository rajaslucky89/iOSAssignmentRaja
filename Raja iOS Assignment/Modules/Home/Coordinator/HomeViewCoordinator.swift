//
//  HomeViewCoordinator.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift

class HomeViewCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    public var viewModel = HomeViewModel()
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = rootViewController as! HomeView
        viewController.viewModel    = viewModel
        
        viewModel.didTapCardDetail
            .flatMap( { [unowned self] (data) in
                return self.coordinateToCardDetail(with: data)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.never()
        
    }
    
    private func coordinateToCardDetail(with data: UnsplashPhotos) -> Observable<Void> {
        let detailCoordinator = CardDetailCoordinator(rootViewController: rootViewController)
        detailCoordinator.photos = data
        return coordinate(to: detailCoordinator)
            .map { _ in () }
    }
    
}

