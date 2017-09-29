//
//  RepoListPresenter.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//

import Foundation
import RxSwift
import RxDataSources


struct RepoListModel {
    var title : String
    var sections : [GitHubRepositorySection]
    var isLoading : Bool

}


class  RepoListPresenter {
    let bag = DisposeBag()
    
    let router : RepoListRouter
    let interactor : RepoListInteractor
    weak var viewController : RepoListIntents!
    
    
    
    init(router : RepoListRouter,
         interactor : RepoListInteractor,
         viewController : RepoListIntents) {
        self.router = router
        
        
        self.interactor = interactor
        self.viewController = viewController
        
    }
    
    
    func sections() -> Observable<RepoListModel> {
        let intentLoad = viewController.intentLoad().flatMap({ (username)  in
            return self.listRepositories(forUser: username)
        })
        
        
        let reloadIntent = Observable.combineLatest(viewController.intentLoad(), viewController.intentReload()) { (username, _) -> String in
            return username
            }.flatMap { (username)  in
                return self.listRepositories(forUser: username)
        }
        
        

        
        
        return Observable.merge([intentLoad, reloadIntent]).map { (user, sections)  in
            return RepoListModel(title: user, sections: sections, isLoading: false)
        }
    }
    
    func attach() {
        

        Observable.merge(sections()).subscribe(onNext: { (model) in
            self.viewController?.display(model: model)
        }).addDisposableTo(self.bag)
        
        
        self.viewController.intentSelectRepository().subscribe(onNext: { repository in
            self.router.go(to: .details(repository))
        }).addDisposableTo(self.bag)
    
    }
    
    
    
    func listRepositories(forUser user : String) -> Observable<(String, [GitHubRepositorySection])> {
        return self.interactor.listRepositories(forUser: user)
            .map({ (repositories) -> (String, [GitHubRepositorySection]) in
                return (user, [GitHubRepositorySection(items: repositories)])
        })
            /*return RepoListModel(title: Observable.just(user), sections : Observable.just(sections), isLoading : Observable.just(false))
        })//.startWith(RepoListModel(title: Observable.just(user), sections: Observable.just([]), isLoading: Observable.just(true)))*/
    }
    

    
}
