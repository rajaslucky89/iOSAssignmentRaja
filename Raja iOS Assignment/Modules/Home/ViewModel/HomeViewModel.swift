//
//  HomeViewModel.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift
import RxCocoa

// MARK: HomeViewModelInput
protocol HomeViewModelInput: AnyObject {
    var didTapCardDetail: PublishSubject<UnsplashPhotos> { get }
}

/// View model interface that is visible to the HomeView
class HomeViewModel: BaseViewModel, HomeViewModelInput {
    
    // MARK: Variables
    private var repository = HomeRepository()
    var photos = BehaviorRelay<[UnsplashPhotos]>(value: [])
    var successGetData = BehaviorRelay<Bool?>(value: nil)
    let didTapCardDetail = PublishSubject<UnsplashPhotos>()
    var request = PhotoRequest.shared
    var canLoadMore = BehaviorRelay<Bool?>(value: nil)
    var isListView = true
    
    var numberOfRows: Int {
        return photos.value.count
    }
    
    func cellForRowAt (indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        if isListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
            cell.photoData = photos.value[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as! CardCollectionViewCell
            cell.photoData = photos.value[indexPath.row]
            return cell
        }
    }
    
    func getPhotos(_ state: DataLoadState = .newest) {
        guard Reachability.shared.isConnectedToNetwork == true else {
            self.error.onNext(ErrorModel(APIClientError.noInternetConnection.localizedDescription))
            return
        }
        
        self.request.state = state
        if state == .newest {
            self.state.onNext(.loading)
            self.request.page = 1
        } else {
            self.request.page += 1
        }
        
        repository.getPhotos(request: self.request)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] model in
                guard let data = model?.results else { return }
                if let maxPage = model?.totalPages {
                    self.canLoadMore.accept(request.page < maxPage)
                }
                
                if state == .newest {
                    self.photos.accept(data)
                } else {
                    self.photos.accept(self.photos.value + data)
                }
                
                self.state.onNext(.finish)
            },onError: { [unowned self] error in
                self.state.onNext(.error)
            }).disposed(by: disposeBag)
        
    }
    
    func removeArray() {
        self.photos.accept([])
    }
}
