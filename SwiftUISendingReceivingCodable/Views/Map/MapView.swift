//
//  MapView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 31/07/2020.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {

    let locationManager = CLLocationManager()
    @Binding var alertErrorDetected: Bool
    @Binding var velibSelected: Velib?
    @Binding var alertError: Alert?
    @Binding var mapType : MKMapType
    @Binding var service: Services
    @Binding var annotations: [Annotation]?
    
    
    // MARK: - Required protocol methods of UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        let uiView = MKMapView()
        uiView.delegate = context.coordinator
        goToUserLocation(uiView: uiView)
        return uiView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = mapType

        if annotations?.count != uiView.annotations.count - 1 {
            uiView.removeAnnotations(uiView.annotations)
            if let annos = annotations {
                uiView.addAnnotations(annos)
            }
        }
    }
    
    // MARK: - Functions
    func refresh() {
        print("dans refresh")
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(mapView: self)
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
    
extension MapView {
    func fetchVelib(recordid: String) {
        let url = UrlDataLocationEnum.velib.rawValue + recordid
        WebServiceManager.shared.fetchDataWithTypeResult(url: url,
                                    decodable: VelibResponse.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let velibs = data.records, velibs.count > 0 {
                        self.createVelibDetail(velibs)
                    } else {
                        alertError = AlertManager.shared.createNetworkAlert(NetworkError.serverLost)
                        alertErrorDetected = true
                    }
                }
            case .failure(let error):
                alertError = AlertManager.shared.createNetworkAlert(error)
                alertErrorDetected = true
            }
        }
    }
    
    fileprivate func createVelibDetail(_ dataResults: [Velib]) {
        if let velib = dataResults.first {
            DispatchQueue.main.async {
                velibSelected = velib
            }
        }
    }
}
