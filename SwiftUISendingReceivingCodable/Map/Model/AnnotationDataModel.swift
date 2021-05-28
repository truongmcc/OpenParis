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
        var refCoordinates: [Double]?
        var refName: String?
        var refAdresse: String?
        
        var coordonneesGeo: [Double]?
        var geo_point_2d: [Double]?
        var xy: [Double]?
        var geom_x_y: [Double]?
        var name: String?
        var nomSite: String?
        var adresse: String?
        var voie: String?
        
        // CaseIterable crée un tableau d'enum !!!
        enum CodingKeys: String, CodingKey, CaseIterable {
            case coordonneesGeo = "coordonnees_geo"
            case geo_point_2d = "geo_point_2d"
            case xy = "xy"
            case geom_x_y = "geom_x_y"
            case name = "name"
            case nomSite = "nom_site"
            case adresse = "adresse"
            case voie = "voie"
        }
 
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try? values.decode(String.self, forKey: .adresse)
            for codingKey in CodingKeys.allCases {
                if let coords = try? values.decode([Double].self, forKey: codingKey) {
                    refCoordinates = coords
                    break
                }
            }
            for codingKey in CodingKeys.allCases {
                if let ref = try? values.decode(String.self, forKey: codingKey) {
                    refName = ref
                    break
                }
            }
            for codingKey in CodingKeys.allCases {
                if let ref = try? values.decode(String.self, forKey: codingKey) {
                    refAdresse = ref
                    break
                }
            }
        }
    }
}


