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
        fetchAllVelibs()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Annotation
        guard let recordid = annotation?.id else { return }
        fetchVelib(recordid: recordid)
    }
}

extension MapCoordinator {
    
    fileprivate func fetchVelib(recordid: String) {
        let url = UrlDataLocationEnum.velib.rawValue + recordid
        WebServiceManager.shared.loadDataWithTypeResult(url: url,
                                    decodable: VelibResponse.self) { result in
            switch result {
            case .success(let data):
                if let velibs = data.records {
                    DispatchQueue.main.async {
                        self.createVelibDetail(velibs)
                    }
                }
            case .failure(let error):
                self.createErrorAlert(error)
            }
        }
    }
    
    fileprivate func fetchAllVelibs() {
        WebServiceManager.shared.loadDataWithTypeResult(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseAnnotationDatas.self) {
            result in
            switch result {
            case .success(let data):
                if let dataResults = data.records {
                    DispatchQueue.main.async {
                        self.map.velibsViewModel.velibAnnotations = dataResults
                        self.createAnnotations(results: dataResults)
                    }
                }
            case .failure(let error):
                self.createErrorAlert(error)
            }
        }
    }
    
    fileprivate func createErrorAlert(_ error: NetworkError?) {
        DispatchQueue.main.async {
            self.map.alertError = Alert(title: Text("Error Network"), message: Text(error?.description ?? "kjhkj"), dismissButton: .default(Text("OK")) {
                self.map.showingErrorAlert = false
            })
            self.map.showingErrorAlert = true
        }
    }
    
    fileprivate func createAnnotations(results: [AnnotationDatas]) {
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
            }
        }
    }
    
    fileprivate func createErrorAlert(_ error: Error?) {
        if let error = error?.localizedDescription {
            self.map.alertError = Alert(title: Text("Error Network"), message: Text(error), dismissButton: .default(Text("OK")) {
                self.map.showingErrorAlert = false
            })
        }
        self.map.showingErrorAlert = true
    }

}
