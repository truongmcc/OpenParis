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
        print(recordid)
        map.showAnnotationDetail(recordId: recordid)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        map.mapViewModel.centerCordinate = mapView.centerCoordinate
        if map.serviceViewModel.rayOfDistance <= 700 {
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

        let image = UIImage(named: "velib")?.withRenderingMode(.alwaysTemplate)
        dequeuedView.image = image
        
        return dequeuedView
    }
}

extension UIImage {

    func colorized(color : UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context!.setBlendMode(.multiply)
        draw(in: rect)
        context!.clip(to: rect, mask: self.cgImage!)
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return colorizedImage
    }
}
