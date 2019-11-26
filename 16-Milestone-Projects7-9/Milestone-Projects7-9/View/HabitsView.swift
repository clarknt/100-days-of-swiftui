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
                ForEach(0..<habits.activities.count, id: \.self) { i in
                    NavigationLink(destination: EditActivity(activity: self.$habits.activities[i])) {
                        VStack(alignment: .leading) {
                            Text(self.habits.activities[i].title)
                                .font(.headline)
                            Text(self.habits.activities[i].description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                Text("Completed")
                                Text("\(self.habits.activities[i].completedTimes)")
                                    .padding(.horizontal, -5)
                                    .foregroundColor(self.habits.activities[i].completedTimes > 0 ? .green : .red)
                                Text("times")
                            }
                            .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
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
