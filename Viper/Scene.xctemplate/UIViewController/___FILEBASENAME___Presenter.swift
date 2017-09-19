//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import RxSwift



struct ___VARIABLE_sceneName___Model {

    
}


class  ___VARIABLE_sceneName___Presenter {
    let bag = DisposeBag()
    
    let router : ___VARIABLE_sceneName___Router
    let interactor : ___VARIABLE_sceneName___Interactor
    weak var viewController : ___VARIABLE_sceneName___Intents?
    
    
    
    init(router : ___VARIABLE_sceneName___Router,
         interactor : ___VARIABLE_sceneName___Interactor,
         viewController : ___VARIABLE_sceneName___Intents) {
        self.router = router
        self.interactor = interactor
        self.viewController = viewController
        
    }
    
    
    func attach() {
        _ = Observable.merge([]).subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).addDisposableTo(bag)
        
    }
    

    
}
