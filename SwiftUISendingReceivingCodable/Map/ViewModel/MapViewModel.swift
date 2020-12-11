//
//  MapViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 05/11/2020.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var annotations = [ServiceAnnotation]()
    //@Published var mapType = MKMapType.standard
    @Published var centerUserLocation = false
    @Published var refreshAnnotations = false
    @Published var centerCordinate: CLLocationCoordinate2D?
    
    func createAnnotations(results: [AnnotationDataModel]) {
        refreshAnnotations = true
        var annos = [ServiceAnnotation]()
        for annotation in results {
            annos.append(ServiceAnnotation(data: annotation))
        }
        annotations = annos
    }
    
    func fetchAllAnnotations(of service: ServiceViewModel, distance: Int, completion: @escaping
                                (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
        let center: (x: Double, y: Double)
        center.x = centerCordinate?.latitude ?? 0
        center.y = centerCordinate?.longitude ?? 0
        ServicesWebServices.shared.fetchAllAnnotations(of: service, centerCoordinate: center)
        { result in
            completion(result)
        }
    }
}

