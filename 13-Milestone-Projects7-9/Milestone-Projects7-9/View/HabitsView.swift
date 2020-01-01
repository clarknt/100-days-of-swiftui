//
//  ContentView.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var habits = Habits()
    @State var showAddActivity = false

    var body: some View {
        NavigationView {
            List {
                ForEach(habits.activities) { activity in
                    NavigationLink(destination: EditActivity(habits: self.habits, activityId: activity.id)) {
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.headline)
                            Text(activity.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                Text("Completed")
                                Text("\(activity.completedTimes)")
                                    .padding(.horizontal, -5)
                                    .foregroundColor(activity.completedTimes > 0 ? .green : .red)
                                Text("times")
                            }
                            .font(.subheadline)
                        }
                    }
                }
                .onDelete { offsets in
                    self.habits.activities.remove(atOffsets: offsets)
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showAddActivity = true
                    }) {
                        Image(systemName: "plus")
                            // increase tap area size
                            .frame(width: 44, height: 44)
                    }
            )
        }
        .sheet(isPresented: $showAddActivity) {
            AddActivity(habits: self.habits)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
