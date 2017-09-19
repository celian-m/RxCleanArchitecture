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

protocol ___FILEBASENAMEASIDENTIFIER___Intents : class {

    func display(viewModel : ___FILEBASENAMEASIDENTIFIER___Model)
}



class ___FILEBASENAMEASIDENTIFIER___Controller : UIViewController, ___FILEBASENAMEASIDENTIFIER___Intents {
    
    var presenter : ___FILEBASENAMEASIDENTIFIER___Presenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attach()
        
    }
    
    func display(viewModel:___FILEBASENAMEASIDENTIFIER___Model) {

    }
    
}
