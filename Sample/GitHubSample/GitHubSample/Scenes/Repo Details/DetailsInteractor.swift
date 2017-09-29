//
//  DetailsInteractor.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 29/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//


import Foundation
import RxSwift

struct DetailsInteractor {
    let repository = GitHubRepository()
    
    func commits(repository : E.Repository) -> Observable<[E.Repository.Commit]> {
        return self.repository.commits(repository:repository)
    }

}
