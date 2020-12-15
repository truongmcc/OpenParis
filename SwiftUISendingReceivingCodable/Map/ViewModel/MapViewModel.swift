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
    
    func fetchAllAnnotations(of userSettings: UserSettings, completion: @escaping
                                (Result<ResponseAnnotationDatas, NetworkErrorEnum>) -> Void) {
        let center: (x: Double, y: Double)
        center.x = centerCordinate?.latitude ?? 0
        center.y = centerCordinate?.longitude ?? 0
        ServicesWebServices.shared.fetchAllAnnotations(of: userSettings, centerCoordinate: center)
        { result in
            completion(result)
        }
    }
}

