//
//  NetworkManager.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import Foundation
import SwiftUI
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private var cancellable: AnyCancellable?
    private init() { }
    
    func createUrlRequest(url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        return URLRequest(url: url)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    // Generic with result type version
    func fetchDataWithTypeResult<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkErrorEnum>) -> Void) {
        guard let urlRequest = createUrlRequest(url: url) else {
            completion(.failure(NetworkErrorEnum.badURL))
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkErrorEnum.requestFailed))
                return
            }
            do {
                print(data)
                let decodedResponse  = try JSONDecoder().decode(decodable.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print(error)
                completion(.failure(NetworkErrorEnum.decodingFailed))
            }
        }
        .resume()
    }
    
    func fetchDataWithCombine<T: Codable>(url: String,
                                          decodable: T.Type,
                                          completion: @escaping (Result<T, NetworkErrorEnum>) -> Void) {
        guard let urlRequest = createUrlRequest(url: url) else {
            completion(.failure(NetworkErrorEnum.badURL))
            return
        }
          
        self.cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    completion(.failure(NetworkErrorEnum.requestFailed))
                    throw URLError(.badServerResponse)
                }
                return element.data
            }.eraseToAnyPublisher()
            .decode(type: decodable.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                print ("Received completion: \($0).")
            },
            receiveValue: {
                user in print ("Received user: \(user).")
                completion(.success(user))
            })
        
        
        
//
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            guard let data = data else {
//                completion(.failure(NetworkErrorEnum.requestFailed))
//                return
//            }
//            do {
//                print(data)
//                let decodedResponse  = try JSONDecoder().decode(decodable.self, from: data)
//                completion(.success(decodedResponse))
//            } catch {
//                print(error)
//                completion(.failure(NetworkErrorEnum.decodingFailed))
//            }
//        }
//        .resume()
    }
    
//     Generic without result type version
//    static func fetchData<T: Codable>(allAnnotationsEndpoint: String, decodable: T.Type, completion: @escaping (T?, Error?)->Void) {
//        guard let urlRequest = createUrlRequest(annotationEndpoint: url) else {
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
