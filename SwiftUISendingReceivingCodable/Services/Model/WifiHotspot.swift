//
//  WifiHotspot.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 29/11/2020.
//

struct WifiHotspotResponse: Response {
    var records: [Service]?
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        records = try values.decode([WifiHotspot].self, forKey: .records)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.records as? [WifiHotspot], forKey: .records)
    }
}

struct WifiHotspot: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.wifiHotspot

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
        var cp: String?
        var name: String?
        var arcAdresse: String?
        var idpw: String?
        var etat2: String?
        var nbBorneWifi: Int?
        
        enum CodingKeys: String, CodingKey {
            case cp = "cp"
            case name = "nom_site"
            case arcAdresse = "arc_adresse"
            case idpw = "idpw"
            case etat2 = "etat2"
            case nbBorneWifi = "nombre_de_borne_wifi"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cp = try? values.decode(String.self, forKey: .cp)
            name = try? values.decode(String.self, forKey: .name)
            arcAdresse = try values.decode(String.self, forKey: .arcAdresse)
            idpw = try? values.decode(String.self, forKey: .idpw)
            etat2 = try? values.decode(String.self, forKey: .etat2)
            nbBorneWifi = try? values.decode(Int.self, forKey: .nbBorneWifi)
        }
    }
}
