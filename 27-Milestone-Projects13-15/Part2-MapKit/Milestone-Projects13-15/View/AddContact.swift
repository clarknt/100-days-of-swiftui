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

    @State private var showingErrorAlert = false
    @State private var errorAlertMessage = ""

    // monitor keyboard events to allow scrolling when it appears
    @ObservedObject private var keyboard = KeyboardResponder()

    @State private var imageSourceType: ImageSourceType = .library

    private let locationFetcher = LocationFetcher()

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
                    HStack {
                        // two buttons in the same row would result in both being
                        // considered tapped when the row is tapped: use text instead
                        Text("Take new...")
                            .onTapGesture(perform: takePicture)

                        Spacer()

                        Text("Select existing...")
                            .onTapGesture(perform: selectPhoto)
                    }
                    .foregroundColor(Color.accentColor)
                }
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
            }
            // add space for the keyboard
            .padding(.bottom, keyboard.currentHeight)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$uiImage, sourceType: self.imageSourceType)
            }
            .alert(isPresented: $showingErrorAlert, content: {
                Alert(title: Text(errorAlertMessage))
            })
            .navigationBarTitle(Text("Add contact"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.addContact() },
                       label: { Text("Add").padding(15) }
                )
            )
            .onAppear() {
                self.locationFetcher.start()
            }
        }
    }

    func loadImage() {
        guard let uiImage = self.uiImage else { return }
        self.image = Image(uiImage: uiImage)
    }

    func takePicture() {
        if ImagePicker.isCameraAvailable() {
            self.imageSourceType = .camera
            self.showingImagePicker = true
        }
        else {
            self.errorAlertMessage = "Camera is not available"
            self.showingErrorAlert = true
        }
    }

    func selectPhoto() {
        self.imageSourceType = .library
        self.showingImagePicker = true
    }

    func addContact() {
        guard !self.name.isEmpty else {
            errorAlertMessage = "Please provide a name"
            showingErrorAlert = true
            return
        }

        var person = Person(name: self.name)

        if let uiImage = uiImage {
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                person.setImage(image: jpegData)
            }
        }

        if let location = self.locationFetcher.lastKnownLocation {
            person.latitude = location.latitude
            person.longitude = location.longitude
            person.locationRecorded = true
        }
        else {
            person.locationRecorded = false
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
