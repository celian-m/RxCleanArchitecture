//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

enum ___VARIABLE_sceneName___Route {
    case close
}

/**
 * The ___VARIABLE_sceneName___RouterInterface protocol declares an interface for ___VARIABLE_sceneName___Router
 * Using an interface let you stub the component for Unit Testing
 */
protocol ___VARIABLE_sceneName___RouterInterface {
    static func instantiateController() -> ___VARIABLE_sceneName___Controller
    func go(to route: ___VARIABLE_sceneName___Route)
}

class ___VARIABLE_sceneName___Router:  ___VARIABLE_sceneName___RouterInterface {
    
    private init() {}
    private weak var controller: ___VARIABLE_sceneName___Controller?
    
    static func instantiateController() -> ___VARIABLE_sceneName___Controller {
        let router = ___VARIABLE_sceneName___Router()
        let controller = ___VARIABLE_sceneName___Controller(nibName: "___VARIABLE_sceneName___Controller", bundle: Bundle(for: ___VARIABLE_sceneName___Controller.classForCoder()))
        let presenter = ___VARIABLE_sceneName___Presenter(router: router, controller: controller)
        router.controller = controller
        controller.presenter = presenter
        return controller
    }
    
    func go(to route: ___VARIABLE_sceneName___Route) {
        switch route {
            case .close:
            controller?.navigationController?.popViewController(animated: true)
        }
    }
}
