//
//  MapView.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-29.
//  Copyright © 2019 clarknt. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView {
    var annotation: MKPointAnnotation?
}

extension MapView: UIViewRepresentable {

    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        if let annotation = annotation {
            mapView.setCenter(annotation.coordinate, animated: false)
        }
        return mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ uiView: MKMapView, context: Self.Context) {
        if let annotation = annotation {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
        }
    }

    /// Creates a `Coordinator` instance to coordinate with the
    /// `UIView`.
    ///
    /// `Coordinator` can be accessed via `Context`.
    func makeCoordinator() -> Self.Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Location"

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                // no pop up
                annotationView?.canShowCallout = false
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }
    }
}
