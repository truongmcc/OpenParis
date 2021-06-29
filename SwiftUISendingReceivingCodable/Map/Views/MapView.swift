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

struct MapView: UIViewRepresentable, MapViewProtocol {
    let locationManager = CLLocationManager()
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var serviceViewModel: ServiceViewModel
    @ObservedObject var userSettings: UserSettings
    
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
        uiView.mapType = userSettings.mapType == 0 ? MKMapType.standard : MKMapType.satellite
        if mapViewModel.shouldeRefreshAnnotations == true {
            uiView.removeAnnotations(uiView.annotations)
            let annos = mapViewModel.annotations
            uiView.addAnnotations(annos)
            mapViewModel.shouldeRefreshAnnotations = false
        }
        if mapViewModel.centerUserLocation {
            goToUserLocation(uiView: uiView)
            mapViewModel.centerUserLocation = false
        }
        
        if mapViewModel.centerOnAnnotation == true {
            goTo(uiView: uiView)
        }
    }
    
    // MARK: - Functions
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
            guard let location = self.locationManager.location else {
                return
            }
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                    longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)
        }
    }
    
    func goTo(uiView: MKMapView) {
        DispatchQueue.main.async {
            uiView.setCenter(mapViewModel.centerCoordinate!, animated: true)
        }
        mapViewModel.centerOnAnnotation = false
    }
    
}
