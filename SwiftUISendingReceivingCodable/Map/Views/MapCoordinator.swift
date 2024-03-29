//
//  MapCoordinator.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/08/2020.
//

import MapKit
import CoreLocation

final class MapCoordinator: NSObject, MKMapViewDelegate {
    var map: MapView
    init(mapView: MapView) {
        map = mapView
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? ServiceAnnotation
        guard let recordid = annotation?.id else { return }
        map.showAnnotationDetail(recordId: recordid)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        map.mapViewModel.centerCoordinate = mapView.centerCoordinate
        if map.userSettings.rayOfDistance <= 700 {
            map.loadMap()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ServiceAnnotation else {
            return nil
        }
        
        let identifier = "ServiceAnnotationView"
        guard let dequeuedView = mapView.dequeueReusableAnnotationView (
                withIdentifier: identifier) else {
            return nil
        }
        dequeuedView.annotation = annotation
        dequeuedView.image = UIImage(named: map.userSettings.typeService.rawValue)
        // récup icones : https://icones8.fr/
        // change png color : https://onlinepngtools.com/change-png-color
        return dequeuedView
    }
}
