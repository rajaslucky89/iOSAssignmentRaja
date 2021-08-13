//
//  BaseCoordinator.swift
//  Raja iOS Assignment
//
//  Created by Raja Syahmudin on 14/08/21.
//

import RxSwift

open class BaseCoordinator<ResultType>: NSObject {
    
    public typealias CoordinatorResult = ResultType
    public let disposeBag           = DisposeBag()
    private let identifier          = UUID()
    private var childCoordinators   = [UUID: Any]()
    
    private func store<T>(_ coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func release<T>(to coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    @discardableResult
    open func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                    self?.release(to: coordinator) })
        
    }
    
    open func start() -> Observable<ResultType> {
        fatalError("start() method must be implemented")
    }
    
}
