//
//  ServiceAnnotation.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/08/2020.
// Initialisé à partir des AnnotationDataModel

import MapKit

class ServiceAnnotation: NSObject, MKAnnotation {
    @Published var id: String?
    @Published var coordinate: CLLocationCoordinate2D
    @Published var name: String?
    @Published var adresse: String?
    
    init(data: AnnotationDataModel) {
        self.id = data.idData
        let coordinate = CLLocationCoordinate2D(latitude: data.fieldsData.refCoordinates?.first ?? 0,
                                                longitude: data.fieldsData.refCoordinates?.last ?? 0)
        self.coordinate = coordinate
        self.name = data.fieldsData.refName
        self.adresse = data.fieldsData.refAdresse
    }
}

