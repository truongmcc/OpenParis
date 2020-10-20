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
        fetchAllVelibsWithTypeResult()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Annotation
        guard let recordid = annotation?.id else { return }
        let url = UrlDataLocationEnum.velib.rawValue + recordid
        map.velibsViewModel.getVelib(url) { responseVelib, error in
            if let velibs = responseVelib {
                self.createVelibDetail(velibs)
            } else {
                self.createErrorAlert(error)
            }
        }
    }
}

extension MapCoordinator {
    
    fileprivate func fetchAllVelibs() {
        map.velibsViewModel.fetchVelibs { responseData, error in
            if let velibs = responseData {
                self.createAnnotations(results: velibs)
            } else {
                self.createErrorAlert(error)
            }
        }
    }
    
    fileprivate func fetchAllVelibsWithTypeResult() {
        map.velibsViewModel.fetchVelibsWithTypeResult { result in
            switch result {
            case .success(let data):
                self.createAnnotations(results: data)
            case .failure(let error):
                switch error {
                case .badURL:
                    print("Bad URL")
                    self.createErrorAlert(NetworkError.badURL)
                case .requestFailed:
                    print("Network problems")
                    self.createErrorAlert(NetworkError.requestFailed)
                case .decodingFailed:
                    self.createErrorAlert(NetworkError.decodingFailed)
                case .unknown:
                    self.createErrorAlert(NetworkError.unknown)
                case .noInternet:
                    self.createErrorAlert(NetworkError.noInternet)
                case .serverNotAccessible:
                    self.createErrorAlert(NetworkError.serverNotAccessible)
                }
            }
        }
    }

    fileprivate func createAnnotations(results: [GenericData]) {
        map.velibsViewModel.annotations.removeAll()
        for annotation in results {
            DispatchQueue.main.async {
                self.map.velibsViewModel.annotations.append(Annotation(data: annotation))
            }
        }
    }
 
    fileprivate func createVelibDetail(_ dataResults: [Velib]) {
        if let velib = dataResults.first {
            DispatchQueue.main.async {
                self.map.velibSelected = velib
                self.map.showingDetails = true
            }
        }
    }
    
    fileprivate func createErrorAlert(_ error: Error?) {
        if let error = error?.localizedDescription {
            self.map.velibsViewModel.alertError = Alert(title: Text("Error Network"), message: Text(error), dismissButton: .default(Text("OK")) {
                self.map.showingErrorAlert = false
            })
        }
        self.map.showingErrorAlert = true
    }
    
}
