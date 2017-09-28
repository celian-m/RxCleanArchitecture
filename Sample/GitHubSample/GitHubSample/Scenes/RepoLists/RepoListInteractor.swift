//
//  RepoListInteractor.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//


import Foundation
import RxSwift

struct RepoListInteractor {
    
    let repository = GitHubRepository()
    
    func listRepositories(forUser user : String) -> Observable<[GitHubRepositoryEntitie]> {
        return repository.list(username: user)
    }
    
}
