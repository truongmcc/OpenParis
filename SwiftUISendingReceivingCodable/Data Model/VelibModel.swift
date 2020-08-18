//
//  VelibModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

struct VelibResponse: Codable {
    var records: [Velib]?
}

struct Velib: Codable {
    var velibId: String?
    var fields: Fields
    
    enum CodingKeys: String, CodingKey {
        case velibId = "recordid"
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        velibId = try values.decode(String.self, forKey: .velibId)
        fields = try values.decode(Fields.self, forKey: .fields)
    }
}

struct Fields: Codable {
    var eBike: Int?
    var capacity: Int?
    var name: String
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
    
    enum CodingKeys: String, CodingKey {
        case eBike = "ebike"
        case capacity = "capacity"
        case name = "name"
        case nomArrondissementCommune = "nom_arrondissement_communes"
        case numBikesAvailable = "numbikesavailable"
        case isInstalled = "is_installed"
        case isRenting = "is_renting"
        case mechanical = "mechanical"
        case stationCode = "stationcode"
        case coordonneesGeo = "coordonnees_geo"
        case numDockAvailable = "numdocksavailable"
        case isReturning = "is_returning"
        case dueDate = "duedate"
    }
    
    init( from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eBike = try values.decode(Int.self, forKey: .eBike)
        capacity = try values.decode(Int.self, forKey: .capacity)
        name = try values.decode(String.self, forKey: .name)
        nomArrondissementCommune = try values.decode(String.self, forKey: .nomArrondissementCommune)
        numBikesAvailable = try values.decode(Int.self, forKey: .numBikesAvailable)
        isInstalled = try values.decode(String.self, forKey: .isInstalled)
        isRenting = try values.decode(String.self, forKey: .isRenting)
        mechanical = try values.decode(Int.self, forKey: .mechanical)
        stationCode = try values.decode(String.self, forKey: .stationCode)
        coordonneesGeo = try values.decode([Double].self, forKey: .coordonneesGeo)
        numDockAvailable = try values.decode(Int.self, forKey: .numDockAvailable)
        isReturning = try values.decode(String.self, forKey: .isReturning)
        dueDate = try values.decode(String.self, forKey: .dueDate)
    }
}



