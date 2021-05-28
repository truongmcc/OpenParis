//
//  ColonneVerre.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 26/05/2021.
//

import Foundation

struct ColonneVerreResponse: Codable {
    var records: [ColonneVerre]?
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
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        RepositoryNetworking.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: colonneVerreResult) in
            switch result {
            case .success(let data):
                if let service = self.createService(data: data) {
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
        if let dataResponse = data as? ColonneVerreResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
}
