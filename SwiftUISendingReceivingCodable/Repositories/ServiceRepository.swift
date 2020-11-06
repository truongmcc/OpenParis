//
//  ServiceRepository.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

enum ServicesEnum: Int {
    case velib
    case trotinette
    case sanisette
    case fontaine
    case triMobile
    
    func title() -> String {
        switch self {
        case .velib:
            return "Velibs"
        case .trotinette:
            return "Trotinettes"
        case .sanisette:
            return "Sanisettes"
        case .fontaine:
            return
                "Fontaines"
        case .triMobile:
            return "Tri Mobile"
        }
    }
    
    func allAnnotationsUrl() -> String {
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1000"
        case .sanisette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis&q=&rows=1000"
        case .fontaine:
            return
                "https://opendata.paris.fr/api/records/1.0/search/?dataset=fontaines-a-boire&q=&rows=1000"
        case .triMobile:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=tri-mobile0&q=&rows=1000"
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
        case .fontaine:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=fontaines-a-boire&q=recordid%3D"
        case .triMobile:
            return
                "https://opendata.paris.fr/api/records/1.0/search/?dataset=tri-mobile0&q=recordid%3D"
            
            
            
            //%22d245823c927421e84cfe8ab9a3eab077cd64f39e%22
                
//                "https://opendata.paris.fr/api/records/1.0/search/?dataset=tri-mobile0&q=recordid%3D"
        }
    }
}

class ServiceRepository {
    
    static let shared = ServiceRepository()
    private init() { }
        
    func fetchAllAnnotations(of service: ServicesEnum, completion: @escaping (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
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
    
    func fetchFontaine(urlString: String, completion: @escaping (Result<FontaineResponse, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlString,
                                    decodable: FontaineResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchTriMobile(urlString: String, completion: @escaping (Result<TriMobileResponse, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlString,
                                    decodable: TriMobileResponse.self) { result in
            completion(result)
        }
    }
}

