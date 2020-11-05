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
    @Binding var alertError: Alert?
    @Binding var mapType : MKMapType
    @Binding var service: ServicesEnum
    @Binding var annotations: [Annotation]?
    @Binding var showProgressView: Bool
    @Binding var serviceSelected: Any?
    @Binding var refreshAnnotations: Bool
    @Binding var centerUserLocation: Bool
    
    // MARK: - Required protocol methods of UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        let uiView = MKMapView()
        uiView.delegate = context.coordinator
        goToUserLocation(uiView: uiView)
        return uiView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = mapType
        if refreshAnnotations == true {
            uiView.removeAnnotations(uiView.annotations)
            if let annos = annotations {
                uiView.addAnnotations(annos)
            }
        }
        if centerUserLocation {
            goToUserLocation(uiView: uiView)
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
        showProgressView = true
        refreshAnnotations = false
        let url = service.annotationUrl() + recordid
        switch service {
        case .velib:
            ServiceRepository.shared.fetchVelib(urlString: url) { result in
                manageServiceResult(result: result)
            }
        case .trotinette:
            ServiceRepository.shared.fetchTrotinette(urlString: url) { result in
                manageServiceResult(result: result)
            }
        case .sanisette:
            ServiceRepository.shared.fetchSanisette(urlString: url) { result in
                manageServiceResult(result: result)
            }
        case .fontaine:
            ServiceRepository.shared.fetchFontaine(urlString: url) { result in
                manageServiceResult(result: result)
            }
        case .triMobile:
            ServiceRepository.shared.fetchTriMobile(urlString: url) { result in
                manageServiceResult(result: result)
            }
        }
    }
    
    fileprivate func manageServiceResult<T>(result: Result<T, NetworkError>) {
        showProgressView = false
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
            if let dataResponse = data as? VelibResponse, let velib = dataResponse.records?.first {
                serviceSelected = velib
            } else if let dataResponse = data as? TrotinetteResponse, let trotinette = dataResponse.records?.first {
                serviceSelected = trotinette
            } else if let dataResponse = data as? SanisetteResponse, let sanisette = dataResponse.records?.first {
                serviceSelected = sanisette
            } else if let dataResponse = data as? FontaineResponse, let fontaine = dataResponse.records?.first {
                serviceSelected = fontaine
            } else if let dataResponse = data as? TriMobileResponse, let triMobile = dataResponse.records?.first {
                serviceSelected = triMobile
            }
        }
    }
}
