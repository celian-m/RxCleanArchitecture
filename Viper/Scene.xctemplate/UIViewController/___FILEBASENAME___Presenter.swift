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
    private let bag = DisposeBag()
    ///Use the scheduler for debouce, Throttle, etc. The scheduler can be set in the constructor to facilitate tests.
    private let scheduler : SchedulerType
    
    private let router : ___VARIABLE_sceneName___RouterInput
    private let interactor : ___VARIABLE_sceneName___InteractorInput
    private weak var viewController : ___VARIABLE_sceneName___Intents!
    
    
    init(router : ___VARIABLE_sceneName___RouterInput,
         interactor : ___VARIABLE_sceneName___InteractorInput,
         viewController : ___VARIABLE_sceneName___Intents,
         scheduler : SchedulerType = MainScheduler.instance ) {
        self.router = router
        self.interactor = interactor
        self.viewController = viewController
        self.scheduler = scheduler
    }
    
    
    func attach() {
        _ = Observable.merge([]).subscribe(onNext: { [weak self] (model) in
            self?.viewController.display(viewModel: model)
        }).addDisposableTo(bag)
        
    }
    

    
}
