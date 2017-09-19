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

protocol ___VARIABLE_sceneName___Intents : class {

    func display(viewModel : ___VARIABLE_sceneName___Model)
}



class ___VARIABLE_sceneName___Controller : UIViewController, ___VARIABLE_sceneName___Intents {
    
    var presenter : ___VARIABLE_sceneName___Presenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attach()
        
    }
    
    func display(viewModel: ___VARIABLE_sceneName___Model) {

    }
    
}
