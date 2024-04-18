//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//

import SwiftUI

struct ___VARIABLE_sceneName___View: View {
    
    @ObservedObject var presenter: ___VARIABLE_sceneName___Presenter
  
    var body: some View {
        switch presenter.model {
        case .initial:
            return EmptyView()
        }
    }
}

