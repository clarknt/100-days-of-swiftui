//
//  EditView.swift
//  Project14
//
//  Created by clarknt on 2019-12-10.
//  Copyright © 2019 clarknt. All rights reserved.
//

import MapKit
import SwiftUI

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation

    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                Section(header: Text("Nearby...")) {
                    if loadingState == .loaded {
                        List(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                                + Text(page.description)
                                .italic()
                        }
                    } else if loadingState == .loading {
                        Text("Loading…")
                    } else {
                        Text("Please try again later.")
                    }
                }
            }
            .navigationBarTitle("Edit place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
            .onDisappear {
                if self.placemark.wrappedTitle.isEmpty { self.placemark.wrappedTitle = "Unknown location" }
                if self.placemark.wrappedSubtitle.isEmpty { self.placemark.wrappedSubtitle = "Unknown description" }
            }
        }
    }

    func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Incorrect URL: \(urlString)")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let items = try decoder.decode(Result.self, from: data)
                    self.pages = Array(items.query.pages.values).sorted()
                    self.loadingState = .loaded
                    return
                }
                catch {
                    print(
                        """
                        Decoding failed.
                            - Data: \(String(bytes: data, encoding: .utf8) ?? "")
                            - Error: \(error.localizedDescription)
                        """
                    )
                }

            }


            if let error = error {
                print("Request failed: \(error.localizedDescription)")
            }

            self.loadingState = .failed
        }
        .resume()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
