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

enum RepoListRoute {
    case details(Entities.Repository)
}

extension RepoListRoute : Equatable {}

func ==(lhs: RepoListRoute, rhs: RepoListRoute) -> Bool {
    switch (lhs, rhs) {
        case ( let .details(a), let .details(b)):
            return a == b
    }
        
}

protocol RepoListRouterInput {
    func go(to route : RepoListRoute)
}

struct RepoListRouter : RepoListRouterInput {
    
    private weak var controller : RepoListController?
    
    static func instantiateController() -> RepoListController {
        let controller = RepoListController(nibName: "RepoListController", bundle: nil)
        
        let interactor = RepoListInteractor()
        let router = RepoListRouter(controller : controller)
        let presenter = RepoListPresenter(router: router, interactor: interactor, viewController: controller)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route : RepoListRoute) {
        switch route {
        case .details(let repository):
            let detailsController = DetailsRouter.instantiateController(forRepository: repository)
            self.controller?.navigationController?.pushViewController(detailsController, animated: true)
            break
        }
    }
    
    
}
