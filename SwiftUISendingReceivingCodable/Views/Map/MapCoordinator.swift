//
//  MapCoordinator.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/08/2020.
//

import SwiftUI
import MapKit
import CoreLocation

final class MapCoordinator: NSObject, MKMapViewDelegate {
    var map: MapView
    init(mapView: MapView) {
        map = mapView
        super.init()
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Annotation
        guard let recordid = annotation?.id else { return }
        print(recordid)
        map.showAnnotationDetail(recordid: recordid)
    }
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//                if centerUserLocation {
//                    let latDelta:CLLocationDegrees = 0.5
//                    let lonDelta:CLLocationDegrees = 0.5
//                    let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
//                    let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
//                    mapView.setRegion(region, animated: true)
//                    centerLocationOnce = false
//                }
//            }
}
