//
//  FontaineDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

struct FontaineResponse: Codable {
    var records: [Fontaine]?
}

struct Fontaine: Codable {
    var fontaineId: String?
    var fields: Fields
    
    enum CodingKeys: String, CodingKey {
        case fontaineId = "recordid"
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fontaineId = try values.decode(String.self, forKey: .fontaineId)
        fields = try values.decode(Fields.self, forKey: .fields)
    }
    
    struct Fields: Codable {
        var commune: String?
        var typeObjet: String?
        var dispo: String?
        var voie: String?
        var noVoirieImpair: String?
        var noVoiriePair: String?
        
        enum CodingKeys: String, CodingKey {
            case commune = "commune"
            case typeObjet = "type_objet"
            case dispo = "dispo"
            case voie = "voie"
            case noVoirieImpair = "no_voirie_impair"
            case noVoiriePair = "no_voirie_pair"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            commune = try? values.decode(String.self, forKey: .commune)
            typeObjet = try? values.decode(String.self, forKey: .typeObjet)
            dispo = try? values.decode(String.self, forKey: .dispo)
            voie = try? values.decode(String.self, forKey: .voie)
            noVoirieImpair = try? values.decode(String.self, forKey: .noVoirieImpair)
            noVoiriePair = try? values.decode(String.self, forKey: .noVoiriePair)
        }
    }
}
