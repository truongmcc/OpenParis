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
                        self.map.alertError = AlertManager.shared.createErrorAlert(NetworkError.serverLost)
                        self.map.alertErrorDetected = true
                    }
                }
            case .failure(let error):
                self.map.alertError = AlertManager.shared.createErrorAlert(error)
                self.map.alertErrorDetected = true
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

}
