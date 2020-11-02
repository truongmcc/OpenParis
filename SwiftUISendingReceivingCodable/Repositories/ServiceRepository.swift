//
//  ServiceRepository.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

enum Services: Int {
    case velib
    case trotinette
    
    func urlForAll() -> String {
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000&facet=name&facet=is_installed&facet=is_renting&facet=is_returning&facet=nom_arrondissement_communes"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1300"
        }
    }
    
    func url() -> String {
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=recordid%3D"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=recordid%3D"
        }
    }
}

class ServiceRepository {
    
    static let shared = ServiceRepository()
    private init() { }
    
    func fetchVelib(urlString: String, completion: @escaping (Result<VelibResponse, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlString,
                                    decodable: VelibResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchTrotinette(urlString: String, completion: @escaping (Result<TrotinetteResponse, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlString,
                                    decodable: TrotinetteResponse.self) { result in
            completion(result)
        }
    }
}
