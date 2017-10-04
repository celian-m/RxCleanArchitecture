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



private struct MockRouter : ___VARIABLE_sceneName___RouterInput {
    
    let goSubject = PublishSubject<___VARIABLE_sceneName___Route>()
    func go(to route: ___VARIABLE_sceneName___Route) {
        goSubject.onNext(route)
    }
    
}

private struct MockInteractor : ___VARIABLE_sceneName___InteractorInput {
    
}

private class MockController : ___VARIABLE_sceneName___Intents {
    
    /* Sample
     
     let loadPublisher = PublishSubject<String>()
     func intentLoad() -> Observable<String> {
         return loadPublisher
     }
     */
    
    let modelPublisher = PublishSubject<___VARIABLE_sceneName___Model>()
    func display(model: ___VARIABLE_sceneName___Model) {
        modelPublisher.onNext(model)
    }
}

class RepoListPresenterTests: XCTestCase {
    
    private var bag : DisposeBag!
    private var scheduler : TestScheduler!
    private var router : MockRouter!
    private var controller : MockController!
    private var interactor : ___VARIABLE_sceneName___InteractorInput!
    private var presenter : ___VARIABLE_sceneName___Presenter!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler.init(initialClock: 0)
        router = MockRouter()
        controller = MockController()
        interactor = MockInteractor()
        
  
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func attach() {
        presenter = ___VARIABLE_sceneName___Presenter(router: router,
                                                      interactor: interactor,
                                                      viewController: controller,
                                                      scheduler : scheduler)
        
        
        presenter.attach()
    }
    /*
     func testSimpleCase() {
     
     //Don't forget to attach :]
     attach()
     
     
     //Create the input Stream, ie the stream of event mocking the controller
     let intents = scheduler.createHotObservable([next(10, "celian-m")])
     intents.bind(to: controller.loadPublisher).addDisposableTo(bag)
     
     //Redirect the output stream into a Scheduler Observer
     let observer = scheduler.createObserver(RepoListModel.self)
     controller.modelPublisher.bind(to: observer).addDisposableTo(bag)
     
     //Start the Timer
     scheduler.start()
     //Tell the timer when the test is completed
     scheduler.advanceTo(50)
     
     //Describe the exepected results
     let results = [next(10, RepoListModel.init(title: "celian-m", sections: [], isLoading: false, error: nil))]
     
     //Check if expected matches actual
     XCTAssertEqual(results, observer.events)
     
     }*/
    

    

    
}
