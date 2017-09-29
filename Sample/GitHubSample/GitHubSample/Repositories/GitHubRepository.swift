//
//  GitHubRepository.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import UIKit
import RxSwift

extension URL {
    struct GitHub  {
        static func list(_ user : String) -> URL? { return  URL(string: "https://api.github.com/users/\(user)/repos") }
        static func commits(_ repo : E.Repository) -> URL? { return  URL(string: "https://api.github.com/repos/\(repo.login)/\(repo.name)/commits") }
    }
}

enum GitHubErrors : Error {
    case cannotParse
    case unhandled(String)
}

class GitHubRepository: Repository {

    func list(username name : String) -> Observable<[Entities.Repository]> {
        
        return request(.get, URL.GitHub.list(name)).flatMap({ (json) -> Observable<[Entities.Repository]> in
            
            guard let arrayOfRepositories = json as? [[String : Any]] else { throw  GitHubErrors.cannotParse }

            let arrayOfEntities = Entities.Repository.from(jsonList: arrayOfRepositories)
            return Observable.just(arrayOfEntities)
        })
        //return Observable.just([] as [String])
    }
    
    
    
    func commits(repository : E.Repository) -> Observable<[E.Repository.Commit]> {
        
        return request(.get, URL.GitHub.commits(repository)).flatMap({ (json) -> Observable<[Entities.Repository.Commit]> in
            
            guard let arrayOfRepositories = json as? [[String : Any]] else { throw  GitHubErrors.cannotParse }
            
            let arrayOfEntities = Entities.Repository.Commit.from(jsonList: arrayOfRepositories)
            return Observable.just(arrayOfEntities)
        })
        //return Observable.just([] as [String])
    }
    
}
