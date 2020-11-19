//
//  MapViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 05/11/2020.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var annotations = [Annotation]()
    @Published var mapType = MKMapType.standard
    @Published var centerUserLocation = false
    @Published var refreshAnnotations = false
    
    func createAnnotations(results: [AnnotationDataModel]) {
        refreshAnnotations = true
        var annos = [Annotation]()
        for annotation in results {
            annos.append(Annotation(data: annotation))
        }
        annotations = annos
    }
    
    func fetchAllAnnotations(of service: ServicesEnum, completion: @escaping
                                (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
        ServicesWebServices.shared.fetchAllAnnotations(of: service)
        { result in
            completion(result)
        }
    }
}

