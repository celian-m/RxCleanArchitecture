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
    }
}

enum GitHubErrors : Error {
    case cannotParse
}

class GitHubRepository: Repository {

    func list(username name : String) -> Observable<[GitHubRepositoryEntitie]> {
        
        return request(.get, URL.GitHub.list(name)).flatMap({ (json) -> Observable<[GitHubRepositoryEntitie]> in
            
            guard let arrayOfRepositories = json as? [[String : Any]] else { throw  GitHubErrors.cannotParse }

            let arrayOfEntities = GitHubRepositoryEntitie.from(jsonList: arrayOfRepositories)
            return Observable.just(arrayOfEntities)
        })
        //return Observable.just([] as [String])
    }
    
}
