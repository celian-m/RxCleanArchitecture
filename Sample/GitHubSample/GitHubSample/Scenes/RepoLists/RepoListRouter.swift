//
//  RepoListRouter.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//


import Foundation
import UIKit



struct RepoListRouter {
    
    enum Route {
        
    }
    
    private weak var controller : RepoListController?
    
    static func instantiateController() -> RepoListController {
        let controller = RepoListController(nibName: "RepoListController", bundle: nil)
        
        let interactor = RepoListInteractor()
        let router = RepoListRouter(controller : controller)
        let presenter = RepoListPresenter(router: router, interactor: interactor, viewController: controller)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route : Route) {
//        switch route {
//
//        }
    }
    
    
}
