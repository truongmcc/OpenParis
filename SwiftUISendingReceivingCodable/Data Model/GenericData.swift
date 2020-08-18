//
//  GenericData.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/08/2020.
//

enum DataTypeEnum {
    case velib
    case autres
}

struct ResponseData: Codable {
    var records: [GenericData]?
}

struct GenericData: Codable {
    var idData: String?
    var fieldsData: FieldsData

    enum CodingKeys: String, CodingKey {
        case idData = "recordid"
        case fieldsData = "fields"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idData = try values.decode(String.self, forKey: .idData)
        fieldsData = try values.decode(FieldsData.self, forKey: .fieldsData)
    }
}

struct FieldsData: Codable {
    var coordonneesGeo: [Double]?

    enum CodingKeys: String, CodingKey {
        case coordonneesGeo = "coordonnees_geo"
    }

    init( from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coordonneesGeo = try values.decode([Double].self, forKey: .coordonneesGeo)
    }
}
