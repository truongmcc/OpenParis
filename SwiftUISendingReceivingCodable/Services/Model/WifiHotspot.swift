//
//  WifiHotspot.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 29/11/2020.
//

struct WifiHotspotResponse: Codable {
    var records: [WifiHotspot]?
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
        var nomSite: String?
        var arcAdresse: String?
        var idpw: String?
        var etat2: String?
        var nbBorneWifi: Int?
        
        enum CodingKeys: String, CodingKey {
            case cp = "cp"
            case nomSite = "nom_site"
            case arcAdresse = "arc_adresse"
            case idpw = "idpw"
            case etat2 = "etat2"
            case nbBorneWifi = "nombre_de_borne_wifi"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cp = try? values.decode(String.self, forKey: .cp)
            nomSite = try? values.decode(String.self, forKey: .nomSite)
            arcAdresse = try values.decode(String.self, forKey: .arcAdresse)
            idpw = try? values.decode(String.self, forKey: .idpw)
            etat2 = try? values.decode(String.self, forKey: .etat2)
            nbBorneWifi = try? values.decode(Int.self, forKey: .nbBorneWifi)
        }
    }
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        ServicesWebServices.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: Result<WifiHotspotResponse, NetworkErrorEnum>) in
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
        if let dataResponse = data as? WifiHotspotResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
    
}
