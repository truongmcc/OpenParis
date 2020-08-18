//
//  MapView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 31/07/2020.
//

import SwiftUI
import MapKit
import CoreLocation

final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var map: MapView
    init(mapView: MapView) {
        map = mapView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Annotation
        let recordid = annotation?.id
        let url = UrlDataLocationEnum.velib.rawValue + recordid!
        MapServices.shared.loadAnnotation(url: url,
                                          decodable: VelibResponse.self) { decodedResponse, error in
            if let dataResults = decodedResponse?.records {
                self.createDetailAnnotation(dataResults)
            } else { // si échec, recharger la map au cas ou les recordId ont été raffraichis sur le serveur
                MapServices.shared.loadMap(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseData.self, completion: { decodedResponse, error in
                    MapServices.shared.loadAnnotation(url: url,
                                                      decodable: VelibResponse.self) { decodedResponse, error in
                        if let dataResults = decodedResponse?.records {
                            self.createDetailAnnotation(dataResults)
                        } else {
                            self.createErrorAlert(error)
                        }
                    }
                })
            }
        }
    }
    
    fileprivate func createDetailAnnotation(_ dataResults: [Velib]) {
        for annotation in dataResults {
            DispatchQueue.main.async {
                self.map.selectedAnnotation = VelibAnnotation(velib: annotation)
                self.map.showingDetails = true
            }
        }
    }
    
    fileprivate func createErrorAlert(_ error: Error?) {
        if let error = error?.localizedDescription {
            self.map.alertError = Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")) {
                self.map.showingErrorAlert = false
            })
        }
        self.map.showingErrorAlert = true
    }
}

struct MapView: UIViewRepresentable {
    let locationManager = CLLocationManager()
    var annotations: [Annotation]
    @Binding var showingDetails: Bool
    @Binding var showingErrorAlert: Bool
    @Binding var selectedAnnotation: VelibAnnotation?
    @Binding var alertError: Alert?
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(mapView: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let uiView = MKMapView()
        goToUserLocation(uiView: uiView)
        return uiView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
        uiView.addAnnotations(annotations)
    }
    
    func goToUserLocation(uiView: MKMapView) {
        uiView.showsUserLocation = true
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            guard let location = locationManager.location else {
                return
            }
            let locValue:CLLocationCoordinate2D = location.coordinate
            print("CURRENT LOCATION = \(locValue.latitude) \(locValue.longitude)")
            
            let coordinate = CLLocationCoordinate2D(
                latitude: locValue.latitude, longitude: locValue.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)
        }
    }
}
