//
//  DetailView.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-17.
//  Copyright © 2019 clarknt. All rights reserved.
//

import MapKit
import SwiftUI

struct DetailView: View {
    @State private var pickerTab = 0
    var person: Person

    var body: some View {
        VStack {
            Picker("", selection: $pickerTab) {
                Text("Photo").tag(0)
                Text("Event location").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if pickerTab == 0 {
                getImage(for: person)
                    .resizable()
                    .scaledToFit()
                    // for placeholders
                    .foregroundColor(Color.gray)
                    .tag("Photo")
            }
            else {
                if person.locationRecorded {
                    MapView(annotation: getAnnotation())
                }
                else {
                    Text("Location was not recorded for this contact")
                        .padding()
                }
            }

            Spacer()
        }
        .navigationBarTitle(Text(person.name), displayMode: .inline)

    }

    func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }

    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
        return annotation
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(name: "Tim Cook"))
    }
}
