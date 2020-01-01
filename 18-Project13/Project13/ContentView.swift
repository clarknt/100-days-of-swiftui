//
//  ContentView.swift
//  Project13
//
//  Created by clarknt on 2019-12-02.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterIntensity = 0.5
    // challenge 3
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5

    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    // challenge 1
    @State private var showingNoPictureOnSave = false

    let context = CIContext() // note: expensive to create, so do it once and for all

    var body: some View {
        let intensity = Binding<Double>(
            get: { self.filterIntensity },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )

        // challenge 3
        let radius = Binding<Double>(
            get: { self.filterRadius },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )

        // challenge 3
        let scale = Binding<Double>(
            get: { self.filterScale },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )

        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.1, green: 0.1, blue: 0.1))

                    // SwiftUI does not allow using "if let" here
                    // a simpler if must be used
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        ZStack {
                            Text("Tap to select a picture")
                                .foregroundColor(.white)

                            // challenge 1
                            VStack {
                                Text(" ").padding() // top
                                Text(" ").padding() // middle
                                Text("No picture to save") // bottom
                                    .foregroundColor(.orange)
                                    .padding()
                                    .opacity(showingNoPictureOnSave ? 1 : 0)
                            }
                        }
                        .font(.headline)
                    }
                }
                .cornerRadius(20)
                .onTapGesture {
                    self.showingImagePicker = true
                }

                // challenge 3
                VStack {
                    if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                        HStack {
                            Text("Intensity")
                            Slider(value: intensity)
                        }
                    }

                    if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Text("Intensity").opacity(0) // force same width
                                Text("Radius")
                            }
                            Slider(value: radius)
                        }
                    }

                    if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Text("Intensity").opacity(0) // force same width
                                Text("Scale")
                            }
                            Slider(value: scale)
                        }
                    }
                }
                .padding(.vertical)

                HStack {
                    // challenge 2
                    Button("\(currentFilter.formattedName)") {
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            // challenge 1
                            self.animateNoPictureMessage()
                            return
                        }

                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = { print("Success saving image") }
                        imageSaver.errorHandler = { print("Error saving image: \($0.localizedDescription)") }
                        imageSaver.writePhotoToAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            // challenge 3
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            // challenge 3
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        // reset sliders
        self.filterIntensity = 0.5
        self.filterRadius = 0.5
        self.filterScale = 0.5
        loadImage()
    }

    // challenge 1
    func animateNoPictureMessage() {
        let duration = 0.75

        withAnimation(.linear(duration: duration)) {
            self.showingNoPictureOnSave = true
        }
        // animating with a delay for the disappearance resulted in the
        // appearance animation not showing. using asyncAfter instead.
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.linear(duration: duration)) {
                self.showingNoPictureOnSave = false
            }
        }
    }
}

// challenge 2
extension CIFilter {
    var formattedName: String {
        let removeCI = name.replacingOccurrences(of: "CI",
                              with: "",
                              range: name.range(of: name))

        let spaceOnUpperCase = removeCI.replacingOccurrences(of: "([A-Z])",
                              with: " $1",
                              options: .regularExpression,
                              range: removeCI.range(of: removeCI))

        return spaceOnUpperCase.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
