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

enum ___VARIABLE_sceneName___Model {
    case loading
    case display
    case error
}

class  ___VARIABLE_sceneName___Presenter {
    private let bag = DisposeBag()
    ///Use the scheduler for debouce, Throttle, etc. The scheduler can be set in the constructor to facilitate tests.
    private let scheduler: SchedulerType
    
    private let router: ___VARIABLE_sceneName___RouterInput
    private let interactor: ___VARIABLE_sceneName___InteractorInput
    private weak var viewController: ___VARIABLE_sceneName___Intents?
    private var routePublisher = PublishSubject<___VARIABLE_sceneName___Route>()
    
    init(router: ___VARIABLE_sceneName___RouterInput,
         interactor: ___VARIABLE_sceneName___InteractorInput,
         viewController: ___VARIABLE_sceneName___Intents,
         scheduler: SchedulerType = MainScheduler.instance ) {
        self.router = router
        self.interactor = interactor
        self.viewController = viewController
        self.scheduler = scheduler
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach() {
        guard let viewController = viewController else { return }
        
        
        let loadIntent = viewController?.loadIntent()
            .map { ___VARIABLE_sceneName___Model.display }
            .startWith(.loading)
            .catchError({ (error) -> Observable<___VARIABLE_sceneName___Model> in
                return Observable.just(___VARIABLE_sceneName___Model.error(error))
            })
        //    _ = Observable.merge([]).subscribe(onNext: { [weak self] (model) in
        //    self?.viewController?.display(viewModel: model)
        //    }).disposed(by: bag)
        
        routePublisher
            .subscribe(onNext: { [weak self] (route) in
                self?.router.go(to: route) })
            .disposed(by: bag)
        
        viewController.closeErrorIntent()
            .map {___VARIABLE_sceneName___Model.error}
            .bind(to: routePublisher)
            .disposed(by: bag)
    }
    
}
