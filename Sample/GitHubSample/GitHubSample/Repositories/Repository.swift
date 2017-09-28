//
//  Repository.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//


import Foundation
import Alamofire
import RxSwift
import RxAlamofire

public class Repository  {
    
    var session : SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = SessionManager.init(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }
    

    func request(_ method : HTTPMethod, _ url : URL?, body : [String : Any]? = nil, allowsCache : Bool = true) -> Observable<(Any?)> {
        
        
        return session.rx.responseData(method, url!, parameters : body, encoding : JSONEncoding.default)
            .flatMap({ (response, data) -> Observable<(Any?)> in
                
                
                switch response.statusCode {
                case 200:
                    if data.count > 0, let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())) {
                        
                        return Observable.just((json))
                    }
                default:
                    break
                }
                
                return Observable.just(nil)
                
            })
        
        
        
        
        
    }
}



protocol JSONModel {
    static func from(json: Any?) -> Self?
    static func from(jsonList : Any?) -> [Self]
}

extension JSONModel {
    static func from(jsonList : Any?) -> [Self] {
        var result : [Self] = []
        
        if let list = jsonList as? [Any] {
            for elem in list {
                if let anElem = Self.from(json: elem) {
                    result.append(anElem)
                }
            }
        }
        return result
    }
}






