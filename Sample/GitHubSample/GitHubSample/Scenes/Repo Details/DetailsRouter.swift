//
//  DetailsRouter.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 29/09/2017.
//  Copyright (c) 2017 mouce. All rights reserved.
//
//


import Foundation
import UIKit



struct DetailsRouter {
    
    enum Route {
        
    }
    
    private weak var controller : DetailsController?
    
    static func instantiateController(forRepository repository : E.Repository) -> DetailsController {
        let controller = DetailsController(nibName: "DetailsController", bundle: nil)
        
        let interactor = DetailsInteractor()
        let router = DetailsRouter(controller : controller)
        let presenter = DetailsPresenter(router: router, interactor: interactor, viewController: controller, repository : repository)
        controller.presenter = presenter
        
        return controller
    }
    
//    func go(to route : Route) {
//        switch route {
//
//        }
//    }
    
    
}
