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
        map.fetchVelib(recordid: recordid)
    }
}
