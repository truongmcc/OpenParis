//
//  ColonneVerre.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 26/05/2021.
//

import Foundation

struct ColonneVerreResponse: Response {
    var records: [Service]?
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        records = try values.decode([ColonneVerre].self, forKey: .records)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.records as? [ColonneVerre], forKey: .records)
    }
}

struct ColonneVerre: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.colonneVerre
    var fields: Fields?
    
    enum CodingKeys: String, CodingKey {
        case id = "recordid"
        case fields = "fields"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        fields = try values.decode(Fields.self, forKey: .fields)
    }
    
    init() {}
    
    struct Fields: Codable {
        var adresse: String?
        var codePostal: Int?
        var numeroColonne: String?
        
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case codePostal = "code_postal"
            case numeroColonne = "numero_colonne"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try? values.decode(String.self, forKey: .adresse)
            codePostal = try? values.decode(Int.self, forKey: .codePostal)
            numeroColonne = try? values.decode(String.self, forKey: .numeroColonne)
        }
    }
}
