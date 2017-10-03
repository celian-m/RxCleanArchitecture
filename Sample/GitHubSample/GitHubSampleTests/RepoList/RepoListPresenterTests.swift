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
    
    let goSubject = PublishSubject<RepoListRoute>()
    func go(to route: RepoListRoute) {
        goSubject.onNext(route)
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
    
    private var scheduler : SchedulerType!
    private var router : MockRouter!
    private var controller : MockController!
    private var interactor : MockInteractor!
    private var presenter : RepoListPresenter!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler.init(initialClock: 0)
        router = MockRouter()
        controller = MockController()
        interactor = MockInteractor()
        
        presenter = RepoListPresenter(router: router,
                                                      interactor: interactor,
                                                      viewController: controller,
                                                      scheduler : scheduler)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    

    
}
