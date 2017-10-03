//
//  GitHubSampleUITests.swift
//  GitHubSampleUITests
//
//  Created by Célian MOUTAFIS on 03/10/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import XCTest

class ListRepositoriesUItests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClickDetails() {
        
        let app = XCUIApplication()
        app.toolbars.buttons["Redo"].tap()
        
        waitFor(app.staticTexts["localizator"], timeout: 10)
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Sample Project for Clean Swift Architecture using RxSwift"]/*[[".cells.staticTexts[\"Sample Project for Clean Swift Architecture using RxSwift\"]",".staticTexts[\"Sample Project for Clean Swift Architecture using RxSwift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        waitFor(app.staticTexts["celian"], timeout: 10)
        XCTAssertTrue(app.staticTexts["celian"].firstMatch.isVisible)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
