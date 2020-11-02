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
    @Binding var trotinetteSelected: Trotinette?
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
    
    func showAnnotationDetail(recordid: String) {
        let url = service.url() + recordid
        switch service {
        case .velib:
            ServiceRepository.shared.fetchTrotinette(urlString: url) { result in
                treatResult(result: result)
            }
        case .trotinette:
            ServiceRepository.shared.fetchVelib(urlString: url) { result in
                treatResult(result: result)
            }
        }
    }

    fileprivate func treatResult<T>(result: Result<T, NetworkError>) {
        switch result {
        case .success(let data):
            createDetail(data: data)
        case .failure(let error):
            alertError = AlertManager.shared.createNetworkAlert(error)
            alertErrorDetected = true
        }
    }
    
    fileprivate func createDetail<T>(data: T) {
        DispatchQueue.main.async {
            if let dataResponse = data as? VelibResponse, let velibs = dataResponse.records {
                self.createVelibDetail(velibs)
            } else if let dataResponse = data as? TrotinetteResponse, let trotinettes = dataResponse.records {
                self.createTrotinetteDetail(trotinettes)
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
    
    fileprivate func createTrotinetteDetail(_ dataResults: [Trotinette]) {
        if let trotinette = dataResults.first {
            DispatchQueue.main.async {
                trotinetteSelected = trotinette
            }
        }
    }
}
