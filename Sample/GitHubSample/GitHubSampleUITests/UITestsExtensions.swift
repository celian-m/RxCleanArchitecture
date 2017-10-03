//
//  UITestsExtensions.swift
//  GitHubSampleUITests
//
//  Created by Célian MOUTAFIS on 03/10/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import Foundation
import XCTest


extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
    
    func scrollToElement(_ element: XCUIElement) {
        while !element.isVisible{
            swipeUp()
        }
    }
    
    var isVisible : Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}



public  extension XCTestCase {
    var exists : NSPredicate  {
        get {
            return NSPredicate(format: "exists == 1", argumentArray: nil)
        }
    }
    
    var notExists : NSPredicate {
        get {
            return NSPredicate(format: "count == 0", argumentArray: nil)
        }
    }
    
    
    var countGreaterThan2 : NSPredicate {
        get {
            return NSPredicate(format: "count >= 2", argumentArray: nil)
        }
    }
    
    
    
    
    
    func waitFor(_ obj : AnyObject, timeout : TimeInterval = 5) {
        self.expectation(for: exists, evaluatedWith: obj, handler: nil)
        self.waitForExpectations(timeout: timeout) { (error) in
            if (error != nil ) {
                print(XCUIApplication.debugDescription())
            }
        }
    }
    
    func waitForLoaderFinish(_ timeout : TimeInterval = 5){
        let loader = XCUIApplication().activityIndicators
        self.expectation(for: notExists, evaluatedWith: loader, handler: nil)
        self.waitForExpectations(timeout: timeout, handler: nil)
    }
    
}


