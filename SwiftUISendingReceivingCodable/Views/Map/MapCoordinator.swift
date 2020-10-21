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
        print(recordid)
        fetchVelib(recordid: recordid)
    }
    
}

extension MapCoordinator {
    
    fileprivate func fetchVelib(recordid: String) {
        let url = UrlDataLocationEnum.velib.rawValue + recordid
        WebServiceManager.shared.fetchDataWithTypeResult(url: url,
                                    decodable: VelibResponse.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let velibs = data.records, velibs.count > 0 {
                        self.createVelibDetail(velibs)
                    } else {
                        self.createErrorAlert(NetworkError.serverLost)
                    }
                }
            case .failure(let error):
                self.createErrorAlert(error)
            }
        }
    }
    
    fileprivate func fetchAllVelibs() {
        WebServiceManager.shared.fetchDataWithTypeResult(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseAnnotationDatas.self) {
            result in
            switch result {
            case .success(let data):
                if let dataResults = data.records {
                    DispatchQueue.main.async {
                        self.createAnnotations(results: dataResults)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.createErrorAlert(error)
                }
            }
        }
    }
    
    fileprivate func createErrorAlert(_ error: NetworkError?) {
        self.map.alertError = Alert(title: Text("Error Network"), message: Text(error?.description ?? "kjhkj"), dismissButton: .default(Text("OK")) {
            
            self.map.showingErrorAlert = false
            self.fetchAllVelibs()
        })
        self.map.showingErrorAlert = true
    }
    
    fileprivate func createAnnotations(results: [AnnotationDatas]) {
        for annotation in results {
            self.map.annotations.append(Annotation(data: annotation))
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
