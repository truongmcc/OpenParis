//
//  WebServiceManager.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    
    case badURL, requestFailed, decodingFailed, serverNotAccessible, noInternet, serverLost, dataNotFound, unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "The URL request contains error(s)"
        case .requestFailed:
            return "Request failed"
        case .decodingFailed:
            return "Decoding failed"
        case .serverNotAccessible:
            return "Server not accessible."
        case .noInternet:
            return "The Internet connection appears to be offline."
        case .serverLost:
            return "Server lost. Try again"
        case .dataNotFound:
            return "Data not found"
        case .unknown:
            return "Unknown error"
        }
    }
}

class WebServiceManager {
    
    static let shared = WebServiceManager()
    private init() { }
    
    func createUrlRequest(url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        return URLRequest(url: url)
    }
    
    // Generic with result type version
    func fetchDataWithTypeResult<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = createUrlRequest(url: url) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        print(url)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.requestFailed))
                return
            }
            do {
                print(data)
                let decodedResponse  = try JSONDecoder().decode(decodable.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }
        .resume()
    }
    
//     Generic without result type version
//    static func fetchData<T: Codable>(allAnnotationsUrl: String, decodable: T.Type, completion: @escaping (T?, Error?)->Void) {
//        guard let urlRequest = createUrlRequest(annotationUrl: url) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            guard let data = data else {
//                print(error?._code ?? "0")
//                completion(nil, error)
//                return // Handling errors in an enum
//            }
//
//            do {
//                let decodedResponse  = try JSONDecoder().decode(decodable.self, from: data)
//                completion(decodedResponse, nil)
//            } catch {
//                print(error)
//            }
//        }
//        .resume()
//    }
    
}
