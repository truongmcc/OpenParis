//
//  FontaineDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

struct FontaineResponse: Codable {
    var records: [Fontaine]?
}

struct Fontaine: Service, Codable, Identifiable {
    var id: String?
    var typeService = ServicesEnum.fontaine
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
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkError?) -> Void) {
        ServicesWebServices.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: fontaineResult) in
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
        if let dataResponse = data as? FontaineResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
}
