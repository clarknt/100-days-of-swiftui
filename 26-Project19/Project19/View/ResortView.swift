//
//  ResortView.swift
//  Project19
//
//  Created by clarknt on 2020-01-31.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facility?

    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    // challenge 1
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Photo by \(resort.imageCredit)")
                                    .font(.caption)
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .padding(4)
                                    .padding([.bottom, .trailing], 8) // larger padding
                                    .background(Color.white.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .offset(x: 8, y: 8) // then offset to hide rounded corners
                            }
                        }
                    )
                    .clipped()

                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)

                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    // joins the strings with ',' except for the last join which is 'and'
                    // Text(ListFormatter.localizedString(byJoining: resort.facilities))

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }

            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
