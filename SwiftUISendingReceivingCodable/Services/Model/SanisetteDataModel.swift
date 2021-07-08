//
//  SanisetteDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

struct SanisetteResponse: Response {
    var records: [Service]?
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        records = try values.decode([Sanisette].self, forKey: .records)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.records as? [Sanisette], forKey: .records)
    }
}

struct Sanisette: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.sanisette
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
        var arrondissement: String?
        var accesPmr: String?
        var horaire: String?
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case arrondissement = "arrondissement"
            case accesPmr = "acces_pmr"
            case horaire = "horaire"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try? values.decode(String.self, forKey: .adresse)
            arrondissement = try? values.decode(String.self, forKey: .arrondissement)
            accesPmr = try? values.decode(String.self, forKey: .accesPmr)
            horaire = try? values.decode(String.self, forKey: .horaire)
        }
    }
    
    func fetchDetail(of service: ServicesEnum,
                                  urlString: String,
                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        RepositoryNetworking.shared.fetchDetail(of: service,
                                                urlString: urlString) { (result: Result<SanisetteResponse, NetworkErrorEnum>) in
            
            switch result{
            case .success(let data):
                if let service = data.records?.first {
                    completionHandler(service, false, nil)
                } else {
                    completionHandler(nil, true, NetworkErrorEnum.dataNotFound)
                }
            case .failure(let error):
                completionHandler(nil, true, error)
            }
        }
    }
}
