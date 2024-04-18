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

	@ObservedObject var viewModel:  ___VARIABLE_sceneName___ViewModel

	var intent : ( ___VARIABLE_sceneName___Presenter.Action) -> ()

	init(_ intent: @escaping (___VARIABLE_sceneName___Presenter.Action) -> (),
          viewModel:  ___VARIABLE_sceneName___ViewModel) {
        self.viewModel = viewModel
        self.intent = intent
    }


    var body: some View {
        VStack {
            Button {
                intent(.load)
            } label: {
            	Text("Load")
            }
            Button {
                intent(.close)
            } label: {
                Text("Close")
            }

            switch viewModel.state {
            	case .loading:
            		Text("Loading")
            	default:
            		Text("Default")

            }

        }
    }
}

#Preview {
     ___VARIABLE_sceneName___View({ _ in () }, viewModel: .init(state: .loading))
}


