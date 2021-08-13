//
//  ArticleDetailViewModel.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift
import RxCocoa

// MARK: CardDetailViewModelInput
protocol CardDetailViewModelInput: AnyObject {
    var didTapImage: PublishSubject<UnsplashPhotos> { get }
}

/// View model interface that is visible to the CardDetailViewController
final class CardDetailViewModel: BaseViewModel {
    var photos = BehaviorRelay<UnsplashPhotos?>(value: nil)
    let didTapImage = PublishSubject<UnsplashPhotos>()
    
}
