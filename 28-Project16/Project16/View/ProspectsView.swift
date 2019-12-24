//
//  ProspectsView.swift
//  Project16
//
//  Created by clarknt on 2019-12-24.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }



    var body: some View {
        NavigationView {
            Text("List of people to come...")
                .navigationBarTitle(title)
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
