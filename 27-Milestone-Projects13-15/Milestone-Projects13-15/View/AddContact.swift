//
//  AddContact.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-17.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AddContact: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var persons: Persons

    @State private var name: String = ""

    @State private var showingImagePicker = false
    @State private var uiImage: UIImage?
    @State private var image: Image?

    @State private var showingEmptyNameAlert = false

    // monitor keyboard events to allow scrolling when it appears
    @ObservedObject private var keyboard = KeyboardResponder()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Photo")) {
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1,
                                                                   lineCap: CGLineCap.round,
                                                                   dash: [5, 5]))
                            .scaledToFit()
                    }
                    Button("Select...") {
                        self.showingImagePicker = true
                    }
                    .frame(maxWidth: .infinity)
                }
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
            }
            // add space for the keyboard
            .padding(.bottom, keyboard.currentHeight)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$uiImage)
            }
            .alert(isPresented: $showingEmptyNameAlert, content: {
                Alert(title: Text("Please provide a name"))
            })
            .navigationBarTitle(Text("Add contact"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.addContact() },
                       label: { Text("Add").padding(15) }
                )
            )
        }
    }

    func loadImage() {
        guard let uiImage = self.uiImage else { return }
        self.image = Image(uiImage: uiImage)
    }

    func addContact() {
        guard !self.name.isEmpty else {
            showingEmptyNameAlert = true
            return
        }

        var person = Person(name: self.name)

        if let uiImage = uiImage {
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                person.setImage(image: jpegData)
            }
        }

        self.persons.add(person: person)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
        AddContact(persons: Persons())
    }
}
