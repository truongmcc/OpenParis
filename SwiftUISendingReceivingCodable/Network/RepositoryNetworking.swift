//
//  RepositoryNetworking.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

class RepositoryNetworking {
    
    static let shared = RepositoryNetworking()
    private init() {}
    
    func fetchAllAnnotations(endPoint: String, completion: @escaping (Result<ResponseAnnotationDatas, NetworkErrorEnum>) -> Void) {
        NetworkManager.shared.fetchDataWithCombine(url: endPoint, decodable: ResponseAnnotationDatas.self) { result in
            completion(result)
        }
    }
    
    func fetchDetail<T: Codable>(of service: ServicesEnum,
                                 urlString: String,
                                 completion: @escaping (Result<T, NetworkErrorEnum>) -> Void) {
        NetworkManager.shared.fetchDataWithTypeResult(url: urlString,
                                                         decodable: service.type()) { result in
            completion(result)
        }
    }
    
}

