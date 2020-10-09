//
//  Annotation.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/08/2020.
// Initialisé à partir des GenericData

import MapKit

class Annotation: NSObject, MKAnnotation {
    
    let id: String?
    let coordinate: CLLocationCoordinate2D

    init(data: GenericData) {
        self.id = data.idData
        let coordinate = CLLocationCoordinate2D(latitude: data.fieldsData.coordonneesGeo?.first ?? 0,
                                                longitude: data.fieldsData.coordonneesGeo?.last ?? 0)
        self.coordinate = coordinate
    }
}
