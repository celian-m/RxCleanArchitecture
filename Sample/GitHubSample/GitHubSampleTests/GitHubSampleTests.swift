//
//  GitHubSampleTests.swift
//  GitHubSampleTests
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import GitHubSample

private class MockRepository: GitHubRepository {
  
    var scheduler : TestScheduler!
    
    
    
    override func list(username name: String) -> Observable<[Entities.Repository]> {
        if name == "empty" {
            return Observable.just([])
        }
        else if name == "delay" {
            return Observable.just([]).delay(10, scheduler: scheduler)
        }
        return Observable.just([E.Repository.init(name: "FakeRepository", description: "Fake description", login: name)])
    }
}


private class MockListIntents : RepoListIntents {

    
    
    var publishLoad = PublishSubject<String>()
    var publishReload = PublishSubject<Void>()
    var publishSelect = PublishSubject<E.Repository>()
    
    var publishModel = PublishSubject<RepoListModel>()
    
    func intentLoad() -> Observable<String> {
        return publishLoad
    }
    
    func intentReload() -> Observable<Void> {
        return publishReload
    }
    
    func intentSelectRepository() -> Observable<E.Repository> {
        return publishSelect
    }
    
    func display(model: RepoListModel) {
        publishModel.onNext(model)
    }
    
    
}

private struct MockRouter : RepoListRouterInput {
    static func instantiateController() -> RepoListController {
        return RepoListController()
    }
    
    
    let publishRoute = PublishSubject<RepoListRoute>()
    func go(to route: RepoListRoute) {
        publishRoute.onNext(route)
    }
    
    
}



class ListRepositoriesTests: XCTestCase {
    
    private var presenter : RepoListPresenter!
    private var listUsesCases : RepoListInteractor!
    private var router : MockRouter!
    private var intents : MockListIntents!
    private var scheduler : TestScheduler!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler.init(initialClock: 0)
        intents = MockListIntents()
        let repository = MockRepository()
        repository.scheduler = scheduler
        listUsesCases = RepoListInteractor.init(repository: repository )
        router = MockRouter()
        presenter = RepoListPresenter.init(router: router, interactor: listUsesCases, viewController: intents, scheduler: scheduler)
        presenter.attach()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testSimpleCase() {
        
        //Simulate user actions
        let loads = scheduler.createHotObservable([next(10, "celian-m"), next(15, "john-doe")])
        let _ = loads.bind(to: intents.publishLoad)
        let observer = scheduler.createObserver(RepoListModel.self)
        
        _ = intents.publishModel.bind(to: observer)
        scheduler.start()
        scheduler.advanceTo(50)
        
        //Describe the exepected results
        let resuls = [ next(10,  RepoListModel(title: "celian-m",
                                               sections: [GitHubRepositorySection.init(items: [E.Repository.init(name: "FakeRepository",
                                                                                                                 description: "Fake description",
                                                                                                                 login: "celian-m")])],
                                               isLoading: false,
                                               error: nil)),
                       next(15,    RepoListModel(title: "john-doe",
                                                 sections: [GitHubRepositorySection.init(items: [E.Repository.init(name: "FakeRepository",
                                                                                                                   description: "Fake description",
                                                                                                                   login: "john-doe")])],
                                                 isLoading: false,
                                                 error: nil))
                    ]
        
        
        //Check if expected matches actual
        XCTAssertEqual(resuls, observer.events)
        
    }
    
    func testReload() {
        
        //Simulate user actions
        _ = scheduler.createHotObservable([next(10, "celian-m")]).bind(to: intents.publishLoad)
        _ = scheduler.createColdObservable([next(15, ())]).bind(to: intents.publishReload)
        
        let observer = scheduler.createObserver(RepoListModel.self)
        
        _ = intents.publishModel.bind(to: observer)
        scheduler.start()
        scheduler.advanceTo(50)
        
        //Describe the exepected results
        let resuls = [ next(10,  RepoListModel(title: "celian-m",
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
        XCTAssertEqual(resuls, observer.events)
        
    }

    func testSuccessThenError() {
        
        //Simulate user actions
        let loads = scheduler.createHotObservable([next(10, "empty"),
                                                   error(20, GitHubErrors.cannotParse)])
        let _ = loads.bind(to: intents.publishLoad)
        
        let observer = scheduler.createObserver(RepoListModel.self)
        
        _ = intents.publishModel.bind(to: observer)
        scheduler.start()
        scheduler.advanceTo(50)
        
        //Describe the exepected results
        let resuls = [ next(10,  RepoListModel(title: "empty", sections: [], isLoading: false, error: nil)),
                       next(20,  RepoListModel(title: "empty", sections: [], isLoading: false, error: GitHubErrors.cannotParse.localizedDescription))]
        
        
        //Check if expected matches actual
        XCTAssertEqual(resuls, observer.events)
    }
    
    
    func testDelay() {
        //Simulate user actions
        let loads = scheduler.createHotObservable([next(5, "delay"),
                                                   next(10, "empty")])
        let _ = loads.bind(to: intents.publishLoad)
        
        let observer = scheduler.createObserver(RepoListModel.self)
        
        _ = intents.publishModel.bind(to: observer)
        scheduler.start()
        scheduler.advanceTo(50)
        
        //Describe the exepected results
        let resuls = [ next(10,  RepoListModel(title: "empty", sections: [], isLoading: false, error: nil))]
        
        
        //Check if expected matches actual
        XCTAssertEqual(resuls, observer.events)
    }
    
    func testGoNext() {
        
        //Simulate user actions
        let loads = scheduler.createHotObservable([next(5, E.Repository.init(name: "Localizator", description: "none", login: "celian-m")),
                                                   next(6, E.Repository.init(name: "Localizator", description: "none", login: "celian-m")) ])
        
        let _ = loads.bind(to: intents.publishSelect)
        
        let observer = scheduler.createObserver(RepoListRoute.self)
        
        _ = router.publishRoute.bind(to: observer)
        scheduler.start()
        scheduler.advanceTo(15)
        
        //Describe the exepected results
        let results = [ next(5, RepoListRoute.details(E.Repository.init(name: "Localizator", description: "none", login: "celian-m")))]
        
        
        //Check if expected matches actual
        XCTAssertEqual(results, observer.events)
    }
    
    
    
    
}
