//
//  ServiceRepository.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

class ServiceRepository {
    
    static let shared = ServiceRepository()
    private init() { }
    
    func fetchAllAnnotations(of service: ServicesEnum, completion: @escaping (Result<ResponseAnnotationDatas, NetworkError>) -> Void) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: service.allAnnotationsUrl(), decodable: ResponseAnnotationDatas.self) { result in
            completion(result)
        }
    }
    
    func fetchDetail<T: Codable>(of service: ServicesEnum,
                                 urlString: String,
                                 completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlString,
                                                         decodable: service.type()) { result in
            completion(result)
        }
    }
}

