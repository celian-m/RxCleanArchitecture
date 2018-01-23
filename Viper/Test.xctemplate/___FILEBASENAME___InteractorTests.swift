//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//



import XCTest
import RxSwift
import RxTest
@testable import <#TargetName#>


class ___VARIABLE_sceneName___InteractorTests: XCTestCase {
    
    private var bag : DisposeBag!
    private var interactor : ___VARIABLE_sceneName___Interactor!

    
    override func setUp() {
        super.setUp()
        bag = DisposeBag()
        interactor = ___VARIABLE_sceneName___Interactor()
    }
    
    override func tearDown() {
        interactor = nil
    }


    /*
     func testSimpleCase() {
       
        _ = interactor.someMethod().subscribe(onNext: { (object) in
            switch object {
            case .a(let value):
                XCTAssertEqual(value, code)
            default:
                XCTFail("Should have found smthing")
            }
        }).disposed(by: bag)
     
     }*/
    

    
}
