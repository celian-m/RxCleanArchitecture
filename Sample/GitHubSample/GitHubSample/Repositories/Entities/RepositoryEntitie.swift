//
//  GitHubRepositoryEntitie.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

struct GitHubRepositorySection {
    var items : [E.Repository]
}

extension GitHubRepositorySection : SectionModelType {
    init(original: GitHubRepositorySection, items: [E.Repository]) {
        self = original
        self.items = items
    }
    
    typealias Item = E.Repository
    
    
}

extension Entities {

    struct Repository : JSONModel, Equatable  {
        
        let name : String
        let description : String
        let login : String
        
        static func from(json: Any?) -> Repository? {
            guard let json = json as? [String : Any] else { return nil}
            guard let owner = json["owner"] as? [String : Any] else { return nil}
            guard let login = owner["login"] as? String else { return nil}
            guard let name = json["name"] as? String else { print("'name' parameter not found"); return nil}
            guard let description = json["description"] as? String else { print("'description' parameter not found"); return nil}
            
            return Repository(name: name, description : description, login : login)
        }
        
        static func ==(lhs: Repository, rhs: Repository) -> Bool {
            return lhs.name == rhs.name
        }
    }
}
