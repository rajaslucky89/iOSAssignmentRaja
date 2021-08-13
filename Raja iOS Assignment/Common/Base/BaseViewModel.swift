//
//  BaseViewModel.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift
import RxCocoa

enum NetworkState {
    case initial
    case loading
    case finish
    case error
}

enum DataLoadState {
    case newest
    case loadmore
}

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    var state = PublishSubject<NetworkState>()
    var hudState = PublishSubject<NetworkState>()
    var error = PublishSubject<ErrorModel>()
    var success = PublishSubject<SuccessModel>()
    
}
