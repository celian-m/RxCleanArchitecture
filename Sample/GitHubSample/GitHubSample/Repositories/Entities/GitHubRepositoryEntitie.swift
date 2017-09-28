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
    var items : [GitHubRepositoryEntitie]
}

extension GitHubRepositorySection : SectionModelType {
    init(original: GitHubRepositorySection, items: [GitHubRepositoryEntitie]) {
        self = original
        self.items = items
    }
    
    typealias Item = GitHubRepositoryEntitie
    
    
}



struct GitHubRepositoryEntitie : JSONModel {
    
    let name : String
    let description : String
    
    
    static func from(json: Any?) -> GitHubRepositoryEntitie? {
        guard let json = json as? [String : Any] else { return nil}
        guard let name = json["name"] as? String else { print("'name' parameter not found"); return nil}
        guard let description = json["description"] as? String else { print("'description' parameter not found"); return nil}
        
        return GitHubRepositoryEntitie(name: name, description : description)
    }
}


extension GitHubRepositoryEntitie : Equatable {
    static func ==(lhs: GitHubRepositoryEntitie, rhs: GitHubRepositoryEntitie) -> Bool {
        return lhs.name == rhs.name
    }
    
    
}
