//
//  TrotinetteModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

struct TrotinetteResponse: Response {
    var records: [Service]?
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        records = try values.decode([Trotinette].self, forKey: .records)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.records as? [Trotinette], forKey: .records)
    }
}

struct Trotinette: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.trotinette
    var fields: Fields?
    
    enum CodingKeys: String, CodingKey {
        case id = "recordid"
        case fields = "fields"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
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

