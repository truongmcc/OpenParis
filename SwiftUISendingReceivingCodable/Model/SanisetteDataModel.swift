//
//  SanisetteDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

struct SanisetteResponse: Codable {
    var records: [Sanisette]?
}

struct Sanisette: Service, Codable {
    var typeService = ServicesEnum.sanisette
    var sanisetteId: String?
    var fields: Fields
    
    enum CodingKeys: String, CodingKey {
        case sanisetteId = "recordid"
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sanisetteId = try values.decode(String.self, forKey: .sanisetteId)
        fields = try values.decode(Fields.self, forKey: .fields)
    }
    
    struct Fields: Codable {
        var adresse: String?
        var arrondissement: String?
        var accesPmr: String?
        var horaire: String?
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case arrondissement = "arrondissement"
            case accesPmr = "acces_pmr"
            case horaire = "horaire"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try values.decode(String.self, forKey: .adresse)
            arrondissement = try values.decode(String.self, forKey: .arrondissement)
            accesPmr = try values.decode(String.self, forKey: .accesPmr)
            horaire = try values.decode(String.self, forKey: .horaire)
        }
    }

}
