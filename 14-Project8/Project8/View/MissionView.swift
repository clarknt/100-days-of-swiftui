//
//  MissionView.swift
//  Project8
//
//  Created by clarknt on 2019-11-03.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]

    init(mission: Mission) {
        self.mission = mission

        var matches = [CrewMember]()

        let astronauts = Astronauts.astronauts
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            }
            else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)

                    // challenge 1
                    Text(self.mission.formattedLaunchDate)
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top)

                    Text(self.mission.description)
                    .padding()

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 166, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    HStack {
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                        if crewMember.role == "Commander" {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(Color.yellow)
                                        }
                                    }
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Missions.missions

    static var previews: some View {
        MissionView(mission: missions[0])
    }
}
