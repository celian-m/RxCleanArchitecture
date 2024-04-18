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


    @IBOutlet weak var mCollectionView : UICollectionView!

    var presenter: ___VARIABLE_sceneName___PresenterInterface!
    let mCollectionViewAdapter: ___VARIABLE_sceneName___Adapter = .init()
    // MARK: - View LifeCycle
    deinit {
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionViewAdapter.attach(to: mCollectionView, delegate: self)
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
            //mCollectionViewAdapter.update(policiesElement)
            removeLoader()
            break
        case .error(let error):
            showAlert(message: error.localizedDescription, actions: UIAlertAction.init(title: "OK", style: .default))
            removeLoader()
            break
        }
    }
}

extension ___VARIABLE_sceneName___Controller: ___VARIABLE_sceneName___AdapterDelegate {
    
}



