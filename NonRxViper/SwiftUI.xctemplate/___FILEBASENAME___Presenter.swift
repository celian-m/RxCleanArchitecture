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
import Combine
import Domain

enum ___VARIABLE_sceneName___ViewModel {
    case initial
}


class ___VARIABLE_sceneName___Presenter: ObservableObject  {
       @Published var model: ___VARIABLE_sceneName___ViewModel = .initial
    
    init() {
          load()
      }
    
    func load() {
    
    }
}
