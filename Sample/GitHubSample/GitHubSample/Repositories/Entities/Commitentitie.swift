//
//  File.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 29/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import Foundation
import RxDataSources


struct CommitSection {
    var items : [E.Repository.Commit]
}

extension CommitSection : SectionModelType {
    init(original: CommitSection, items: [E.Repository.Commit]) {
        self = original
        self.items = items
    }
    
    typealias Item = E.Repository.Commit
}

extension E.Repository {
    struct Commit : Equatable {
        struct Author {
            let name : String
            let email : String
        }
        
        let sha : String
        let message : String
        let author : Author
        
        static func ==(lhs: E.Repository.Commit, rhs: E.Repository.Commit) -> Bool {
            return lhs.sha == rhs.sha
        }
    }
}

extension E.Repository.Commit.Author : JSONModel {
    static func from(json: Any?) -> E.Repository.Commit.Author? {
        
        guard   let json = json as? [String : Any],
                let name = json["name"] as? String,
                let email = json["email"] as? String else {
            return nil
        }
        return E.Repository.Commit.Author(name : name, email : email)
    }
}

extension E.Repository.Commit : JSONModel {
    static func from(json: Any?) -> E.Repository.Commit? {
        
        guard let json = json as? [String : Any],
                let sha = json["sha"] as? String,
                let commit = json["commit"] as? [String:Any],
                let message = commit["message"] as? String,
                let authorJSON = commit["author"] as? [String : Any],
                let author = Author.from(json : authorJSON)  else {
            return nil
        }
        return E.Repository.Commit(sha : sha, message : message, author : author)
    }
}
