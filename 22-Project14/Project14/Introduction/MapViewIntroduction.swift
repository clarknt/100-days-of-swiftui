//
//  MapView.swift
//  Project14
//
//  Created by clarknt on 2019-12-09.
//  Copyright © 2019 clarknt. All rights reserved.
//

import MapKit
import SwiftUI

struct MapViewIntroduction: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MapViewIntroduction>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapViewIntroduction>) {
    }

    func makeCoordinator() -> MapViewIntroduction.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewIntroduction

        init(_ parent: MapViewIntroduction) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
}
