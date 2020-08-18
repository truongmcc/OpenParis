//
//  Annotation.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/08/2020.
//

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

class VelibAnnotation {
    
    var name: String?
    var eBike: Int?
    var capacity: Int?
    var nomArrondissementCommune: String?
    var numBikesAvailable: Int?
    var isInstalled: String?
    var isRenting: String?
    var mechanical: Int?
    var stationCode: String?
    var coordonneesGeo: [Double]?
    var numDockAvailable: Int?
    var isReturning: String?
    var dueDate: String?
    
    init(velib: Velib) {
        self.name = velib.fields.name
        self.eBike = velib.fields.eBike
        self.capacity = velib.fields.capacity
        self.nomArrondissementCommune = velib.fields.nomArrondissementCommune
        self.numDockAvailable = velib.fields.numDockAvailable
        self.numBikesAvailable = velib.fields.numBikesAvailable
        self.isInstalled = velib.fields.isInstalled
        self.isRenting = velib.fields.isRenting
        self.stationCode = velib.fields.stationCode
        self.numDockAvailable = velib.fields.numDockAvailable
        self.isReturning = velib.fields.isReturning
        self.dueDate = velib.fields.dueDate
    }
}
