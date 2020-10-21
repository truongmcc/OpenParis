//
//  MapServices.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 17/08/2020.
//

import Foundation

class MapServices {
    static let shared = MapServices()
    private init() { }
    
    func loadData<T: Codable>(url: String, decodable: T.Type, completion: @escaping (T?, Error?)->Void) {
        WebServiceManager.getContent(url: url, decodable: decodable, completion: { decodedResponse, error in
            completion(decodedResponse, error)
        })
    }
    
    func loadDataWithTypeResult<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        WebServiceManager.getContentWithTypeResult(url: url, decodable: decodable) { result in
            completion(result)
        }
    }
}
