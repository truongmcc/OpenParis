//
//  TrotinetteModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

struct TrotinetteResponse: Codable {
    var records: [Trotinette]?
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
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        RepositoryNetworking.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: trotinetteResult) in
            switch result {
            case .success(let data):
                if let service = createService(data: data) {
                    completionHandler(service, false, nil)
                } else {
                    completionHandler(nil, true, NetworkErrorEnum.dataNotFound)
                }
            case .failure(let error):
                completionHandler(nil, true, error)
            }
        }
    }
    
    func createService<T>(data: T) -> Service? {
        if let dataResponse = data as? TrotinetteResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
}

