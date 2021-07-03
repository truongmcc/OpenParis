//
//  VelibModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

protocol Response: Codable {
    var records: [Service]? { get set }
    func encode(to encoder: Encoder) throws
}

struct VelibResponse: Response {
    var records: [Service]?
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        records = try values.decode([Velib].self, forKey: .records)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.records as? [Velib], forKey: .records)
    }
}

struct Velib: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.velib
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
        var eBike: Int?
        var capacity: Int?
        var name: String
        var nomArrondissementCommune: String?
        var numBikesAvailable: Int?
        var isInstalled: String?
        var isRenting: String?
        var mechanical: Int?
        var stationCode: String?
        var numDockAvailable: Int?
        var isReturning: String?
        var dueDate: String?
        
        enum CodingKeys: String, CodingKey {
            case eBike = "ebike"
            case capacity = "capacity"
            case name = "name"
            case nomArrondissementCommune = "nom_arrondissement_communes"
            case numBikesAvailable = "numbikesavailable"
            case isInstalled = "is_installed"
            case isRenting = "is_renting"
            case mechanical = "mechanical"
            case stationCode = "stationcode"
            case numDockAvailable = "numdocksavailable"
            case isReturning = "is_returning"
            case dueDate = "duedate"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            eBike = try? values.decode(Int.self, forKey: .eBike)
            capacity = try? values.decode(Int.self, forKey: .capacity)
            name = try values.decode(String.self, forKey: .name)
            nomArrondissementCommune = try? values.decode(String.self, forKey: .nomArrondissementCommune)
            numBikesAvailable = try? values.decode(Int.self, forKey: .numBikesAvailable)
            isInstalled = try? values.decode(String.self, forKey: .isInstalled)
            isRenting = try? values.decode(String.self, forKey: .isRenting)
            mechanical = try? values.decode(Int.self, forKey: .mechanical)
            stationCode = try? values.decode(String.self, forKey: .stationCode)
            numDockAvailable = try? values.decode(Int.self, forKey: .numDockAvailable)
            isReturning = try? values.decode(String.self, forKey: .isReturning)
            dueDate = try? values.decode(String.self, forKey: .dueDate)
        }
    }
}
