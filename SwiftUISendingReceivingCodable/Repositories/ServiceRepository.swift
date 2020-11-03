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
    case sanisette
    
    func allAnnotationsUrl() -> String {
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1300"
        case .sanisette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis&q=&rows=1000"
        }
    }
    
    func annotationUrl() -> String {
        switch self {
        case .velib:
            return
                "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=recordid%3D"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=recordid%3D"
        case .sanisette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis&q=recordid%3D"
        }
    }
}

class ServiceRepository {
    
    static let shared = ServiceRepository()
    private init() { }
    
    func fetchAllAnnotations(of service: Services, completion: @escaping (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: service.allAnnotationsUrl(), decodable: ResponseAnnotationDatas.self) { result in
            completion(result)
        }
    }
    
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
    
    func fetchSanisette(urlString: String, completion: @escaping (Result<SanisetteResponse, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlString,
                                    decodable: SanisetteResponse.self) { result in
            completion(result)
        }
    }
}

