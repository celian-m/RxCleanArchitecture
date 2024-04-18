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

protocol ___VARIABLE_sceneName___ControllerInterface: AnyObject {
    func display(_ viewModel:  ___VARIABLE_sceneName___Model)
}

class ___VARIABLE_sceneName___Controller: ___VARIABLE_viewControllerSubclass___ {

    var presenter: ___VARIABLE_sceneName___PresenterInterface!

    // MARK: - View LifeCycle
    deinit {
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.intentLoad()
    }

    @IBAction func closeAction() {
        presenter.intentClose()
    }
}

extension ___VARIABLE_sceneName___Controller: ___VARIABLE_sceneName___ControllerInterface {
    

    // MARK: - Display
    func display(_ viewModel: ___VARIABLE_sceneName___Model) {
        switch viewModel {
        case .loading:
            addLoader()
            break
        case .display:
            removeLoader()
            break
        case .error(let error):
            showAlert(message: error.localizedDescription, actions: UIAlertAction.init(title: "OK", style: .default))
            removeLoader()
            break
        }
    }
}
