//
//  Refreshable.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import UIKit
import RxSwift

private var refreshControll = UIRefreshControl()
private let disposeBag = DisposeBag()

protocol Refreshable where Self: UIViewController {
    func addRefreshControll(to collectionView: UICollectionView, marginTop: CGFloat, completion: @escaping() -> Void)
    func stopRefreshControll()
    func addLoadMore(collectionView: UICollectionView, completion: @escaping() -> Void)
    func endLoadMore(in collectionView: UICollectionView, completion: ((_ collectionView: UICollectionView) -> ())?)
}

extension Refreshable {
    func addRefreshControll(to collectionView: UICollectionView, marginTop: CGFloat = 0, completion: @escaping() -> Void) {
        let refreshView = UIView(frame: CGRect(x: 0, y: marginTop, width: 0, height: 0))
        collectionView.addSubview(refreshView)

        refreshControll = UIRefreshControl()
        refreshControll.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        refreshControll.tintColor = .white
        refreshControll.rx
            .controlEvent(.valueChanged)
            .bind { [unowned self] in
                completion()
            }.disposed(by: disposeBag)
        
        refreshView.addSubview(refreshControll)
        
    }
    
    func stopRefreshControll() {
        refreshControll.endRefreshing()
    }
    
    func addLoadMore(collectionView: UICollectionView, completion: @escaping() -> Void) {
        collectionView.addInfiniteScroll { [unowned self] list in
            completion()
        }
    }
    
    func endLoadMore(in collectionView: UICollectionView, completion: ((_ collectionView: UICollectionView) -> ())?) {
        collectionView.finishInfiniteScroll { collectionView in
            completion?(collectionView)
        }
    }
    
}
