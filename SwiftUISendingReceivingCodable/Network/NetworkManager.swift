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
    
    private var urlCreator = UrlCreator()
    private var dataFetcher = DataFetcher()
    private var dataDecoder = DataDecoder()
    
    private var cancellable: AnyCancellable?
    private init() { }
    
    func fetchDataWithTypeResult<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkErrorEnum>) -> Void) {
        guard let urlRequest = self.urlCreator.createUrlRequest(urlString: url) else {
            completion(.failure(NetworkErrorEnum.badURL))
            return
        }
        self.dataFetcher.fetchData(urlRequest: urlRequest) {
            [weak self] data, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            print(data)
            if let decodedData = self?.dataDecoder.decode(data: data, decodable: decodable.self) {
                print(decodedData)
                completion(.success(decodedData))
            } else {
                completion(.failure(NetworkErrorEnum.decodingFailed))
            }
        }
    }
    
    // Generic with result type version
//    func fetchDataWithTypeResult2<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkErrorEnum>) -> Void) {
//        guard let urlRequest = self.urlCreator.createUrlRequest(urlString: url) else {
//            completion(.failure(NetworkErrorEnum.badURL))
//            return
//        }
//        URLSession.shared.dataTask(with: urlRequest)  { [weak self] data, response, error in
//            guard let data = data else {
//                completion(.failure(NetworkErrorEnum.requestFailed))
//                return
//            }
//            if let decoding = self?.dataDecoder.decode(data: data, decodable: decodable.self) {
//                print(decoding)
//                completion(.success(decoding))
//            } else {
//                completion(.failure(NetworkErrorEnum.decodingFailed))
//            }
//        }
//        .resume()
//    }
    
    func fetchDataWithCombine<T: Codable>(url: String,
                                          decodable: T.Type,
                                          completion: @escaping (Result<T, NetworkErrorEnum>) -> Void) {
        guard let urlRequest = self.urlCreator.createUrlRequest(urlString: url) else {
            completion(.failure(NetworkErrorEnum.badURL))
            return
        }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { error -> NetworkErrorEnum in
                completion(.failure(NetworkErrorEnum.requestFailed))
                return NetworkErrorEnum.requestFailed
            }
            .retry(3)
            .tryMap() { element in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    completion(.failure(NetworkErrorEnum.requestFailed))
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: decodable.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { error in
                print ("Received completion: \(error).")
            },
            receiveValue: {
                decodedData in
                print ("Received user: \(decodedData).")
                completion(.success(decodedData))
            })
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
