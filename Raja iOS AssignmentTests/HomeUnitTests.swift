//
//  HomeUnitTests.swift
//  Raja iOS AssignmentTests
//
//  Created by Raja Syahmudin on 08/08/21.
//

import XCTest
import RxSwift
@testable import Raja_iOS_Assignment

class HomeUnitTests: XCTestCase {

    // Variables
    var viewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    var request = PhotoRequest.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDataListWithError() {
        let expectationForDetail = expectation(description: "success get data list")
        self.request.page = 1
        self.request.perPage = 10
        self.request.search = "home"
        
        HomeRepository()
            .getPhotos(request: request)
            .subscribe(onNext: { data in
                let isSuccess: Bool
                if data != nil {
                    isSuccess = true
                } else {
                    isSuccess = false
                }
                XCTAssertTrue(isSuccess)
                expectationForDetail.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expectationForDetail], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
