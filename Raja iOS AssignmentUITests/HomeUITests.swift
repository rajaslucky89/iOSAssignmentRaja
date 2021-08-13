//
//  HomeUITests.swift
//  Raja iOS AssignmentUITests
//
//  Created by Raja Syahmudin on 08/08/21.
//

import XCTest

class HomeUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        app = nil
        
        super.tearDown()
    }
    
    func testMainApp() {
        app.launch()
        
        let search = app.searchFields["Search ..."]
        search.tap()
        search.typeText("home")
        
        // Tap show movie selection view
        let movieSelection = app.navigationBars.element(boundBy: 0)
        movieSelection.tap()
        
        // Check whether movie selection view exists
        let isSelectionViewExists = movieSelection.waitForExistence(timeout: 2.0)
        XCTAssert(isSelectionViewExists)
        
        app.collectionViews.cells.element(boundBy:0).tap()
        
        // Once back to the home view
        if (app.navigationBars["Tyson"].children(matching: .button).element(boundBy: 2).exists) {
            app.navigationBars["Tyson"].children(matching: .button).element(boundBy: 2).tap()
        }
        
    }
    
}
