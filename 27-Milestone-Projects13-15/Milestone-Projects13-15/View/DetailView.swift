//
//  DetailView.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-17.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var person: Person

    var body: some View {
        getImage(for: person)
            .resizable()
            .scaledToFit()
            // for placeholders
            .foregroundColor(Color.gray)
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
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(name: "Tim Cook"))
    }
}
