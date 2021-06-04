//
//  MapViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 05/11/2020.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var locationManager = CLLocationManager()
    @Published var annotations = [ServiceAnnotation]()
    @Published var centerUserLocation = false
    @Published var centerOnAnnotation = false
    @Published var shouldeRefreshAnnotations = false
    @Published var centerCoordinate: CLLocationCoordinate2D?
    
    func createAnnotations(results: [AnnotationDataModel]) {
        shouldeRefreshAnnotations = true
        var annos = [ServiceAnnotation]()
        for annotation in results {
            annos.append(ServiceAnnotation(data: annotation))
        }
        annotations = annos
    }
    
    func fetchAllAnnotations(of userSettings: UserSettings, completion: @escaping
                                (Result<ResponseAnnotationDatas, NetworkErrorEnum>) -> Void) {
        let center: (x: Double, y: Double)
        center.x = centerCoordinate?.latitude ?? 0
        center.y = centerCoordinate?.longitude ?? 0
        RepositoryNetworking.shared.fetchAllAnnotations(of: userSettings, centerCoordinate: center)
        { result in
            completion(result)
        }
    }
}

