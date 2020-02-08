//
//  ContentView.swift
//  Project19
//
//  Created by clarknt on 2020-01-28.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()

    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    // challenge 3
    var sorted: [Resort] {
        switch sortSelection {
        case .defaultSort:
            return resorts
        case .name:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }

    var sortedFiltered: [Resort] {
        var list = sorted
        list = filteredCountries(resorts: sorted)
        list = filteredSizes(resorts: list)
        list = filteredPrices(resorts: list)

        return list
    }

    @State var showingSheet: Bool = false
    @State var sortSelection = SortType.defaultSort
    @State var countriesSelection = ["All"]
    @State var sizesSelection = ["All"]
    @State var pricesSelection = ["All"]

    var body: some View {
        NavigationView {
            // menu view
            List(sortedFiltered) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)

                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(Color.red)
                    }
                }
            }
            // challenge 3
            .sheet(isPresented: $showingSheet, content: {
                SortAndFilterView(resorts: self.resorts,
                                  sortSelection: self.$sortSelection,
                                  countriesSelection: self.$countriesSelection,
                                  sizesSelection: self.$sizesSelection,
                                  pricesSelection: self.$pricesSelection)
            })
            .navigationBarTitle("Resorts")
                .navigationBarItems(trailing: Button(action: {
                    self.showingSheet = true
                }, label: {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down.circle")
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                    // increase tap area size
                    .padding(15)
                })
            )

            // main view
            WelcomeView()
        }
        .environmentObject(favorites)
        // optional
        //.phoneOnlyStackNavigationView()
    }

    // challenge 3
    func filteredCountries(resorts: [Resort]) -> [Resort] {
        filter(resorts: resorts, selections: countriesSelection, valuePath: \.country)
    }

    func filteredSizes(resorts: [Resort]) -> [Resort] {
        filter(resorts: resorts, selections: sizesSelection, valuePath: \.sizeText)
    }

    func filteredPrices(resorts: [Resort]) -> [Resort] {
        filter(resorts: resorts, selections: pricesSelection, valuePath: \.priceText)
    }

    func filter(resorts: [Resort],
                selections: [String],
                valuePath: KeyPath<Resort, String>) -> [Resort] {

        if selections.contains("All") {
            return resorts
        }

        var list = [Resort]()
        for resort in resorts {
            // resort[keyPath: valuePath] is equivalent to resort.country, resort.sizeText, etc
            if selections.contains(resort[keyPath: valuePath]) {
                list.append(resort)
            }
        }

        return list
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
