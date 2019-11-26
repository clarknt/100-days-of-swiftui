//
//  EditActivity.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct EditActivity: View {
    @Binding var activity: Activity

    var body: some View {
        Form {
            TextField("Title", text: $activity.title)
            TextField("Description", text: $activity.description)
            Stepper(value: $activity.completedTimes, in: 0...Int.max) {
                Text("Completed \(activity.completedTimes) times")
            }
        }
        .navigationBarTitle("Edit Activity")
    }
}

struct EditActivity_Previews: PreviewProvider {
    static var previews: some View {
        EditActivity(activity: .constant(Activity(title: "", description: "")))
    }
}
