//
//  BaseCollectionViewCell.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//


import RxSwift

public class BaseCollectionViewCell: UICollectionViewCell {
    public var disposeBag = DisposeBag()
}

extension BaseCollectionViewCell: Reusable { }
