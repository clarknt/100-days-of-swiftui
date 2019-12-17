//
//  ContentView.swift
//  Project15-Challenge3
//
//  Created by clarknt on 2019-11-01.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let missions: [Mission] = Missions.missions
    let astronauts: [Astronaut] = Astronauts.astronauts

    // challenge 3
    @State var showDate = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit() // shortcut for .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        // challenge 3
                        if self.showDate {
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                                // Project 15 - Challenge 3
                                .accessibility(label: Text(""))
                                .accessibility(value: Text(mission.accessibleLaunchDate))
                        }
                        else {
                            Text(mission.crewNames(astronauts: self.astronauts))
                                .font(.subheadline)
                                // Project 15 - Challenge 3
                                // this avoids hearing "new line"
                                .accessibility(label: Text(""))
                                .accessibility(value: Text(mission.accessibleCrewNames(astronauts: self.astronauts)))
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            // challenge 3
            .navigationBarItems(trailing:
                Button(action: {
                    self.showDate.toggle()
                }, label: {
                    Text("Show \(self.showDate ? "crew" : "date")")
                })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
