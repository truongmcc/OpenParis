//
//  TrotinetteModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

struct TrotinetteResponse: Codable {
    var records: [Trotinette]?
}

struct Trotinette: Service, Codable {
    var typeService = ServicesEnum.trotinette
    var trotinetteId: String?
    var fields: Fields
    
    enum CodingKeys: String, CodingKey {
        case trotinetteId = "recordid"
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trotinetteId = try values.decode(String.self, forKey: .trotinetteId)
        fields = try values.decode(Fields.self, forKey: .fields)
    }
    
    struct Fields: Codable {
        var adresse: String?
        var codePostal: String?
        
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case codePostal = "code_postal"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try values.decode(String.self, forKey: .adresse)
            codePostal = try values.decode(String.self, forKey: .codePostal)
        }
    }
}

