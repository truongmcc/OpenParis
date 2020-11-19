//
//  TriMobileDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

struct TriMobileResponse: Codable {
    var records: [TriMobile]?
}

struct TriMobile: Service, Codable {
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
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkError?) -> Void) {
        ServiceRepository.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: triMobileResult) in
            switch result {
            case .success(let data):
                if let service = self.createService(data: data) {
                    completionHandler(service, false, nil)
                } else {
                    completionHandler(nil, true, NetworkError.dataNotFound)
                }
            case .failure(let error):
                completionHandler(nil, true, error)
            }
        }
    }

    func createService<T>(data: T) -> Service? {
        if let dataResponse = data as? TriMobileResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
}
