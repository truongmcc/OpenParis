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
        mapView.velibsViewModel.fetchVelibs()
    }
    
    fileprivate func createAnnotations(results: [GenericData]) {
        map.velibsViewModel.annotations.removeAll()
        for annotation in results {
            DispatchQueue.main.async {
                self.map.velibsViewModel.annotations.append(Annotation(data: annotation))
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? Annotation
        guard let recordid = annotation?.id else { return }
        let url = UrlDataLocationEnum.velib.rawValue + recordid
        getVelib(url)
    }
    
    fileprivate func createVelibDetail(_ dataResults: [Velib]) {
        for velib in dataResults {
            DispatchQueue.main.async {
                self.map.velibSelected = velib
                self.map.showingDetails = true
            }
        }
    }
    
    fileprivate func createErrorAlert(_ error: Error?) {
        if let error = error?.localizedDescription {
            self.map.velibsViewModel.alertError = Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")) {
                self.map.showingErrorAlert = false
            })
        }
        self.map.showingErrorAlert = true
    }
    
    fileprivate func getVelib(_ url: String) {
        MapServices.shared.loadData(url: url,
                                          decodable: VelibResponse.self) { decodedResponse, error in
            if let dataResults = decodedResponse?.records {
                self.createVelibDetail(dataResults)
            } else { // si échec, recharger la map au cas ou les recordId ont été raffraichis sur le serveur
                MapServices.shared.loadData(url: UrlDataLocationEnum.allVelibs.rawValue, decodable: ResponseData.self, completion: { decodedResponse, error in
                    MapServices.shared.loadData(url: url,
                                                      decodable: VelibResponse.self) { decodedResponse, error in
                        if let dataResults = decodedResponse?.records {
                            self.createVelibDetail(dataResults)
                        } else {
                            self.createErrorAlert(error)
                        }
                    }
                })
            }
        }
    }
    
 
}
