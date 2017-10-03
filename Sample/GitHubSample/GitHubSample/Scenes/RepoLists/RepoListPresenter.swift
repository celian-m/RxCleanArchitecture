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


struct RepoListModel : Equatable {
    static func ==(lhs: RepoListModel, rhs: RepoListModel) -> Bool {
        return lhs.title == rhs.title && lhs.sections.count == rhs.sections.count && lhs.isLoading == rhs.isLoading && lhs.error == rhs.error
    }
    
    var title : String
    var sections : [GitHubRepositorySection]
    var isLoading : Bool
    var error : String?
    
    

}


class  RepoListPresenter {
    let bag = DisposeBag()
    let scheduler : SchedulerType
    let router : RepoListRouterInput
    let interactor : RepoListInteractor
    weak var viewController : RepoListIntents!
    
    
    
    init(router : RepoListRouterInput,
         interactor : RepoListInteractor,
         viewController : RepoListIntents,
         scheduler : SchedulerType = MainScheduler.instance) {
        self.router = router
        self.interactor = interactor
        self.viewController = viewController
        self.scheduler = scheduler
    }
    
    
    func sections() -> Observable<RepoListModel> {
        let intentLoad = viewController.intentLoad().flatMapLatest({ (username)  in
            return self.listRepositories(forUser: username)
        })
        
        
        let reloadIntent = Observable.combineLatest(viewController.intentLoad(), viewController.intentReload()) { (username, _) -> String in
            return username
            }.flatMapLatest { (username)  in
                return self.listRepositories(forUser: username)
        }
        
        return Observable.merge([intentLoad, reloadIntent]).map { (user, sections)  in
            return RepoListModel(title: user, sections: sections, isLoading: false, error : nil)
        }
    }
    
    func attach() {
        Observable.merge(sections())
            .catchError({ (error) -> Observable<RepoListModel> in
                return Observable.just(RepoListModel(title: "", sections: [], isLoading: false, error: error.localizedDescription))
            }).scan(RepoListModel.init(title: "", sections: [], isLoading: false, error: nil), accumulator: { (seed, next) -> RepoListModel in
                if let error = next.error {
                    return RepoListModel(title: seed.title, sections: seed.sections, isLoading: false, error: error)
                }else{
                    return next
                }
            }).subscribe(onNext: { (model) in
                self.viewController.display(model: model)
            }).addDisposableTo(self.bag)
        
        self.viewController.intentSelectRepository().throttle(2, latest: false, scheduler: scheduler).subscribe(onNext: { repository in
            self.router.go(to: .details(repository))
        }).addDisposableTo(self.bag)
    
    }
    
    
    
    func listRepositories(forUser user : String) -> Observable<(String, [GitHubRepositorySection])> {
        return self.interactor.listRepositories(forUser: user)
            .map { (repositories) -> (String, [GitHubRepositorySection]) in
                if repositories.count > 0 {
                    return (user, [GitHubRepositorySection(items: repositories)])
                }
                else{
                    return (user, [])
                }
            }
    }
    

    
}
