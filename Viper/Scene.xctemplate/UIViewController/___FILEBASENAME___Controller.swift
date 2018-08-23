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
import RxSwift
import RxCocoa

protocol ___VARIABLE_sceneName___Intents: RxIntents {
	func loadIntent() -> Observable<Void>
    func display(viewModel: ___VARIABLE_sceneName___Model)
}

class ___VARIABLE_sceneName___Controller: ___VARIABLE_viewControllerSubclass___ {

    var presenter: ___VARIABLE_sceneName___Presenter!

    // MARK: - View LifeCycle
    deinit {
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach()

    }
}

extension ___VARIABLE_sceneName___Controller: ___VARIABLE_sceneName___Intents {
    
    // MARK: - RxIntents
    func loadIntent() -> Observable<Void> {
        return Observable.just(())
    }

    // MARK: - Display
    func display(viewModel: ___VARIABLE_sceneName___Model) {
        switch viewModel {
        case .loading:
            addLoader()
            break
        case .display:
            removeLoader()
            break
        case .error:
            removeLoader()
            break
        }
    }
}
