//
//  MapView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 31/07/2020.
//

import SwiftUI
import MapKit
import Foundation
import CoreLocation

struct MapView: UIViewRepresentable {
    let locationManager = CLLocationManager()
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var serviceViewModel: ServiceViewModel
    @ObservedObject var userSettings = UserSettings()
    @Binding var showLoadingView: Bool
    @Binding var showErrorAlert: Bool
    
    // MARK: - Required protocol methods of UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        let uiView = MKMapView()
        uiView.delegate = context.coordinator
        goToUserLocation(uiView: uiView)
        uiView.register(MKAnnotationView.self,
                        forAnnotationViewWithReuseIdentifier: "ServiceAnnotationView")
        return uiView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let pointsOfInterests = userSettings.pointsOfInterests {
            uiView.pointOfInterestFilter = MKPointOfInterestFilter(including: pointsOfInterests)
        } else {
            uiView.pointOfInterestFilter = MKPointOfInterestFilter.includingAll
        }

        uiView.mapType = mapViewModel.mapType
        if mapViewModel.refreshAnnotations == true {
            uiView.removeAnnotations(uiView.annotations)
            let annos = mapViewModel.annotations
            uiView.addAnnotations(annos)
            mapViewModel.refreshAnnotations = false
        }
        if mapViewModel.centerUserLocation {
            goToUserLocation(uiView: uiView)
            mapViewModel.centerUserLocation = false
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
            let coordinate = CLLocationCoordinate2D(
                latitude: locValue.latitude, longitude: locValue.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)
        }
    }
}

extension MapView {
    
    func showAnnotationDetail(recordId: String) {
        showLoadingView = true
        mapViewModel.refreshAnnotations = false
        serviceViewModel.fetchAnnotationDetail(recordId: recordId) { showError, networkError in
            showLoadingView = false
            showErrorAlert = showError
            if let error = networkError {
                AlertManager.shared.netWorkError = error
            }
        }
    }
    
    func loadMap() {
        serviceViewModel.service = nil
        showLoadingView = true
        mapViewModel.fetchAllAnnotations(of: serviceViewModel, distance: serviceViewModel.rayOfDistance)
        { result in
            showLoadingView = false
            manageAnnotationsResults(result: result)
        }
        mapViewModel.annotations.removeAll()
    }
    
    func manageAnnotationsResults(result: Result<ResponseAnnotationDatas, NetworkError>) {
        switch result {
        case .success(let data):
            if let dataResults = data.records {
                DispatchQueue.main.async {
                    mapViewModel.createAnnotations(results: dataResults)
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.shared.netWorkError = error
                showErrorAlert = true
            }
        }
    }
}
