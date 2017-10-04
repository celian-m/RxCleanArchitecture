//
//  RepoListPresenterTests.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 03/10/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//



import XCTest
import RxSwift
import RxTest
@testable import GitHubSample



private struct MockRouter : RepoListRouterInput {
    
    let goPublisher = PublishSubject<RepoListRoute>()
    func go(to route: RepoListRoute) {
        goPublisher.onNext(route)
    }
    
}

private struct MockInteractor : RepoListInteractorInput {
    func listRepositories(forUser user: String) -> Observable<[E.Repository]> {
        return Observable.just([])
    }
}

private class MockController : RepoListIntents {
    
    let reloadPublisher = PublishSubject<Void>()
    func intentReload() -> Observable<Void> {
        return reloadPublisher
    }
    
    
    func intentSelectRepository() -> Observable<E.Repository> {
        return selectPublisher
    }
    let selectPublisher = PublishSubject<E.Repository>()
    
    let loadPublisher = PublishSubject<String>()
    func intentLoad() -> Observable<String> {
        return loadPublisher
    }
    
    
    
    let modelPublisher = PublishSubject<RepoListModel>()
    func display(model: RepoListModel) {
        modelPublisher.onNext(model)
    }
}

class RepoListPresenterTests: XCTestCase {
    
    private var bag : DisposeBag!
    private var scheduler : TestScheduler!
    private var router : MockRouter!
    private var controller : MockController!
    private var interactor : RepoListInteractorInput!
    private var presenter : RepoListPresenter!
    
    override func setUp() {
        super.setUp()
        bag = DisposeBag()
        scheduler = TestScheduler.init(initialClock: 0)
        router = MockRouter()
        controller = MockController()
        interactor  = MockInteractor()     
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func attach() {
        presenter = RepoListPresenter(router: router,
                                      interactor: interactor,
                                      viewController: controller,
                                      scheduler : scheduler)
        
        presenter.attach()
    }

    func testSimpleCase() {
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

    }
    
    
    func testSimpleErrorCase() {
        
        struct MockErrorInteractor : RepoListInteractorInput {
            func listRepositories(forUser user: String) -> Observable<[E.Repository]> {
                return Observable.error(GitHubErrors.cannotParse)
            }
        }
        interactor = MockErrorInteractor()
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
        let results = [next(10, RepoListModel(title: "", sections: [], isLoading: false, error: GitHubErrors.cannotParse.localizedDescription))]
        
        //Check if expected matches actual
        XCTAssertEqual(results, observer.events)
        
    }
    
    func testSuccessThenErrorCase() {
        
        struct MockErrorInteractor : RepoListInteractorInput {
            func listRepositories(forUser user: String) -> Observable<[E.Repository]> {
                return user == "error" ? Observable.error(GitHubErrors.cannotParse) : Observable.just([])
            }
        }
        interactor = MockErrorInteractor()
        attach()
        
        //Create the input Stream, ie the stream of event mocking the controller
        let intents = scheduler.createHotObservable([next(10, "celian-m"),
                                                     next(20, "error")])
        intents.bind(to: controller.loadPublisher).addDisposableTo(bag)
        
        //Redirect the output stream into a Scheduler Observer
        let observer = scheduler.createObserver(RepoListModel.self)
        controller.modelPublisher.bind(to: observer).addDisposableTo(bag)
        
        //Start the Timer
        scheduler.start()
        //Tell the timer when the test is completed
        scheduler.advanceTo(50)
        
        //Describe the exepected results
        let results = [next(10, RepoListModel(title: "celian-m", sections: [], isLoading: false, error: nil)),
                       next(20, RepoListModel(title: "celian-m", sections: [], isLoading: false, error:  GitHubErrors.cannotParse.localizedDescription))]
        
        //Check if expected matches actual
        XCTAssertEqual(results, observer.events)
        
    }
    
    func testReload() {
        struct MockCustomInteractor : RepoListInteractorInput {
            func listRepositories(forUser user: String) -> Observable<[E.Repository]> {
                return Observable.just([E.Repository.init(name: "FakeRepository",
                                                          description: "Fake description",
                                                          login: "celian-m")])
            }
        }
        interactor = MockCustomInteractor()
        attach()
        //Simulate user actions
        scheduler.createHotObservable([next(10, "celian-m")]).bind(to: controller.loadPublisher).addDisposableTo(bag)
        scheduler.createColdObservable([next(15, ())]).bind(to: controller.reloadPublisher).addDisposableTo(bag)
        
        let observer = scheduler.createObserver(RepoListModel.self)
        controller.modelPublisher.bind(to: observer).addDisposableTo(bag)
        
        scheduler.start()
        scheduler.advanceTo(50)
        
        //Describe the exepected results
        let results = [ next(10,  RepoListModel(title: "celian-m",
                                               sections: [GitHubRepositorySection.init(items: [E.Repository.init(name: "FakeRepository",
                                                                                                                 description: "Fake description",
                                                                                                                 login: "celian-m")])],
                                               isLoading: false,
                                               error: nil)),
                       next(15,    RepoListModel(title: "celian-m",
                                                 sections: [GitHubRepositorySection.init(items: [E.Repository.init(name: "FakeRepository",
                                                                                                                   description: "Fake description",
                                                                                                                   login: "celian-m")])],
                                                 isLoading: false,
                                                 error: nil))
        ]
        
        
        //Check if expected matches actual
        XCTAssertEqual(results, observer.events)
        
    }

    
    func testSelectRepository() {
        
        attach()
        //Simulate user actions
        let loads = scheduler.createHotObservable([next(5, E.Repository.init(name: "Localizator", description: "none", login: "celian-m")),
                                                   next(6, E.Repository.init(name: "Localizator", description: "none", login: "celian-m")) ])
        
        loads.bind(to: controller.selectPublisher).addDisposableTo(bag)
        
        let observer = scheduler.createObserver(RepoListRoute.self)
        
        router.goPublisher.bind(to: observer).addDisposableTo(bag)
        scheduler.start()
        scheduler.advanceTo(15)
        
        //Describe the exepected results
        let results = [ next(5, RepoListRoute.details(E.Repository.init(name: "Localizator", description: "none", login: "celian-m")))]
        
        
        //Check if expected matches actual
        XCTAssertEqual(results, observer.events)
    }
    
    
    
}
