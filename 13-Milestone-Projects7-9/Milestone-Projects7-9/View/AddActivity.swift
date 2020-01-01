//
//  AddActivity.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var habits: Habits

    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add Activity")
            .navigationBarItems(trailing: Button("Save") {
                let activity = Activity(title: self.title, description: self.description)
                self.habits.add(activity: activity)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(habits: Habits())
    }
}
