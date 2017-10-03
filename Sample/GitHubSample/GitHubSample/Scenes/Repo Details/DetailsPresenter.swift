//
//  DetailsPresenter.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 29/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//

import Foundation
import RxSwift



struct DetailsModel {
    let title : String
    let commits : [CommitSection]
}


class  DetailsPresenter {
    let bag = DisposeBag()
    
    let router : DetailsRouter
    let interactor : DetailsInteractor
    weak var viewController : DetailsIntents!
    let repository : E.Repository
    
    
    init(router : DetailsRouter,
         interactor : DetailsInteractor,
         viewController : DetailsIntents,
         repository : Entities.Repository) {
        self.router = router
        self.interactor = interactor
        self.viewController = viewController
        self.repository = repository
    }
    
    
    func attach() {
        
        let loadIntent = self.viewController
            .intentLoad()
            .debug("Details Load", trimOutput: false)
            .flatMapLatest { self.listCommits(self.repository) }
            .map { commits in
                return DetailsModel(title: self.repository.name, commits: [CommitSection(items : commits)])
        }
        
        _ = Observable.merge([loadIntent])
            .subscribe(onNext: { [weak self] (model) in
                self?.viewController.display(viewModel: model)
            })
            .addDisposableTo(bag)
        
    }
    
    func listCommits(_ repository : E.Repository) -> Observable<[E.Repository.Commit]> {
        return self.interactor.commits(repository: repository)
    }

    
}
