//
//  ArbreRemarquable.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/11/2020.
//

struct ArbreRemarquableResponse: Codable {
    var records: [ArbreRemarquable]?
}
     
struct ArbreRemarquable: Service, Codable {
    var id: String?
    var typeService = ServicesEnum.arbreRemarquable
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
        var libellefrancais: String?
        var arrondissement: String?
        var circonferenceencm: Double?
        var hauteurenm: Double?
        var espece: String?
        var pepiniere: String?
        var domanialite: String?
        var genre: String?
        var dateplantation: String?
        var remarquable: String?
        var stadedeveloppement: String?

        
        enum CodingKeys: String, CodingKey {
            case adresse = "adresse"
            case libellefrancais = "libellefrancais"
            case arrondissement = "arrondissement"
            case circonferenceencm = "circonferenceencm"
            case hauteurenm = "hauteurenm"
            case espece = "espece"
            case pepiniere = "pepiniere"
            case domanialite = "domanialite"
            case genre = "genre"
            case dateplantation = "dateplantation"
            case remarquable = "remarquable"
            case stadedeveloppement = "stadedeveloppement"
        }
        
        init( from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            adresse = try? values.decode(String.self, forKey: .adresse)
            libellefrancais = try? values.decode(String.self, forKey: .libellefrancais)
            arrondissement = try? values.decode(String.self, forKey: .arrondissement)
            circonferenceencm = try? values.decode(Double.self, forKey: .circonferenceencm)
            hauteurenm = try? values.decode(Double.self, forKey: .hauteurenm)
            espece = try? values.decode(String.self, forKey: .espece)
            pepiniere = try? values.decode(String.self, forKey: .pepiniere)
            domanialite = try? values.decode(String.self, forKey: .domanialite)
            genre = try? values.decode(String.self, forKey: .genre)
            dateplantation = try? values.decode(String.self, forKey: .dateplantation)
            remarquable = try? values.decode(String.self, forKey: .remarquable)
            stadedeveloppement = try? values.decode(String.self, forKey: .stadedeveloppement)
        }
    }
    
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkError?) -> Void) {
        ServicesWebServices.shared.fetchDetail(of: service,
                                             urlString: urlString) { ( result: arbreRemarquableResult) in
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
        if let dataResponse = data as? ArbreRemarquableResponse, let service = dataResponse.records?.first {
            return service
        }
        return nil
    }
}

