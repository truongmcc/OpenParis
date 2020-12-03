//
//  ServicesWebServices.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

class ServicesWebServices {
    
    static let shared = ServicesWebServices()
    private init() { }
    
    func fetchAllAnnotations(of service: ServiceViewModel, distance: Int, completion: @escaping (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
        let url = CreateUrl(service: service)
        NetworkManager.shared.fetchDataWithTypeResult(url: url, decodable: ResponseAnnotationDatas.self) { result in
            completion(result)
        }
    }
    
    func CreateUrl(service: ServiceViewModel) -> String {
        let endPoint = service.typeServiceSelected.allAnnotationsEndpoint()
        var param = ""
        if let userLocation = service.userLocation, service.rayOfDistance != 0 {
            param = "&geofilter.distance=\(userLocation.x)%2C\(userLocation.y)%2C\(String(service.rayOfDistance))"
        }
        return endPoint + param
    }
    
    func fetchDetail<T: Codable>(of service: ServicesEnum,
                                 urlString: String,
                                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        NetworkManager.shared.fetchDataWithTypeResult(url: urlString,
                                                         decodable: service.type()) { result in
            completion(result)
        }
    }
}

