//
//  TriMobileDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

struct TriMobileResponse: Response {
    var records: [Service]?
    enum CodingKeys: String, CodingKey {
        case records = "records"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        records = try values.decode([TriMobile].self, forKey: .records)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.records as? [TriMobile], forKey: .records)
    }
}

struct TriMobile: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.triMobile
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
        var joursDeTenue: String?
        var complementAdresse: String?
        var horaires: String?
        
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case codePostal = "code_postal"
            case joursDeTenue = "jours_de_tenue"
            case complementAdresse = "complement_d_adresse"
            case horaires = "horaires"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try? values.decode(String.self, forKey: .adresse)
            codePostal = try? values.decode(Int.self, forKey: .codePostal)
            joursDeTenue = try? values.decode(String.self, forKey: .joursDeTenue)
            complementAdresse = try? values.decode(String.self, forKey: .complementAdresse)
            horaires = try? values.decode(String.self, forKey: .horaires)
        }
    }
    
    func fetchDetail(of service: ServicesEnum,
                                  urlString: String,
                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        RepositoryNetworking.shared.fetchDetail(of: service,
                                                urlString: urlString) { (result: Result<TriMobileResponse, NetworkErrorEnum>) in
            
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
