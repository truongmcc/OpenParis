//
//  SanisetteDataModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

struct SanisetteResponse: Codable {
    var records: [Sanisette]?
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
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try values.decode(String.self, forKey: .adresse)
            arrondissement = try values.decode(String.self, forKey: .arrondissement)
            accesPmr = try values.decode(String.self, forKey: .accesPmr)
            horaire = try values.decode(String.self, forKey: .horaire)
        }
    }
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        ServicesWebServices.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: SanisetteResult) in
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
        if let dataResponse = data as? SanisetteResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
}
