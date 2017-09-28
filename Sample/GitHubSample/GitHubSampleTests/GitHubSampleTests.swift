//
//  GitHubSampleTests.swift
//  GitHubSampleTests
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import GitHubSample

class GitHubSampleTests: XCTestCase {
    
    
    let listUsesCases = RepoListInteractor()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListRepositories() {
        do {
            let repositories = try listUsesCases.listRepositories(forUser: "celian-m").toBlocking().single()
            XCTAssertNotNil(repositories)
            XCTAssertGreaterThan(repositories?.count ?? 0, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
