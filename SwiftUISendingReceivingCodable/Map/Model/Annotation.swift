//
//  Annotation.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/08/2020.
// Initialisé à partir des AnnotationDataModel

import MapKit

class Annotation: NSObject, MKAnnotation {
    let id: String?
    var coordinate: CLLocationCoordinate2D
    
    init(data: AnnotationDataModel) {
        self.id = data.idData
        let coordinate = CLLocationCoordinate2D(latitude: data.fieldsData.coordinates?.first ?? 0,
                                                longitude: data.fieldsData.coordinates?.last ?? 0)
        self.coordinate = coordinate
    }
}
