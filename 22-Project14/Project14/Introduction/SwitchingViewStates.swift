//
//  SwitchingViewStates.swift
//  Project14
//
//  Created by clarknt on 2019-12-07.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

enum LoadingStateIntroduction {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct SwitchingViewStates: View {
    var loadingState = LoadingStateIntroduction.loading

    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct SwitchingViewStates_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingViewStates()
    }
}
