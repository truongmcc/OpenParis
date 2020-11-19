//
//  AnnotationDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/08/2020.
//

struct ResponseAnnotationDatas: Codable {
    var records: [AnnotationDataModel]?
}

struct AnnotationDataModel: Codable {
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
    
    struct FieldsData: Codable {
        var coordonneesGeo: [Double]?
        var geo_point_2d: [Double]?
        var coordinates: [Double]?
        var xy: [Double]?

        enum CodingKeys: String, CodingKey {
            case coordonneesGeo = "coordonnees_geo"
            case geo_point_2d = "geo_point_2d"
            case xy = "xy"
        }

        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            coordinates = try? values.decode([Double].self, forKey: .coordonneesGeo)
            if coordinates == nil {
                coordinates = try? values.decode([Double].self, forKey: .geo_point_2d)
            }
            if coordinates == nil {
                coordinates = try? values.decode([Double].self, forKey: .xy)
            }
        }
    }
}


