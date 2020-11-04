//
//  TriMobileDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

struct TriMobileResponse: Codable {
    var records: [TriMobile]?
}

struct TriMobile: Codable {
    var triMobileId: String?
    var fields: Fields
    
    enum CodingKeys: String, CodingKey {
        case triMobileId = "recordid"
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        triMobileId = try values.decode(String.self, forKey: .triMobileId)
        fields = try values.decode(Fields.self, forKey: .fields)
    }
    
    struct Fields: Codable {
        var adresse: String?
        var codePostal: Int?
        var joursDeTenue: String?
        
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case codePostal = "code_postal"
            case joursDeTenue = "jours_de_tenue"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try? values.decode(String.self, forKey: .adresse)
            codePostal = try? values.decode(Int.self, forKey: .codePostal)
            joursDeTenue = try? values.decode(String.self, forKey: .joursDeTenue)
        }
    }
}
