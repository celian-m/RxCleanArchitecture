//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import SwiftUI

class ___VARIABLE_sceneName___ViewModel: ObservableObject {

    enum State {
        case loading
        case display
        case error(Error)   
    }

    @Published var state: State

    init(state: State = .loading) {
        self.state = state
    }
}


class  ___VARIABLE_sceneName___Presenter: ObservableObject {
    
    @Published var viewModel: ___VARIABLE_sceneName___ViewModel
    let router: (___VARIABLE_sceneName___Route) -> ()
    

    enum Action {
        case load
        case close   
    }
    
    var isLoading: Bool = true
    

    init(router: @escaping (___VARIABLE_sceneName___Route) -> ()) {
        self.router = router
        self.viewModel = .init()
    }

    private func intentLoad() {
        isLoading = false
        render()
    }

    func intent(_ action: Action) {
        switch action {
            case .load:
                intentLoad()
            case .close:
                router(.close)
        }
    }

    func render(_ error: Error? = nil) {
        let state : ___VARIABLE_sceneName___ViewModel.State   
        if let error  {
            state = .error(error)
        } else if isLoading {
            state = .loading
        } else {
            state = .display
        }
        viewModel.state = state
    }
    
}


extension ___VARIABLE_sceneName___Presenter {
    static var empty: ___VARIABLE_sceneName___Presenter = .init(router: { _ in () })
}

