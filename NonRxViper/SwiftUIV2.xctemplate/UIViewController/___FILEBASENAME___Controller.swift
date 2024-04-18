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
import SwiftUI


class ___VARIABLE_sceneName___Controller: ___VARIABLE_viewControllerSubclass___ {

    var swiftUIView: ___VARIABLE_sceneName___View!
    var hostingController: UIHostingController<___VARIABLE_sceneName___View>!
    
    // MARK: - View LifeCycle
    deinit {
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hostingController = installHosting(swiftUIView)
    }

}
