//
//  WebServiceManager.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import Foundation

enum NetworkError: Error {
    
    case badURL, requestFailed, decodingFailed, serverNotAccessible, noInternet, serverLost, unknown
    
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
            return "Server lost. Relaunch the app"
        case .unknown:
            return "Unknown error"
        }
    }
}

enum UrlDataLocationEnum: String {
    case allVelibs = "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000&facet=name&facet=is_installed&facet=is_renting&facet=is_returning&facet=nom_arrondissement_communes"
    case velib = "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=recordid%3D"
    
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
    
    func fetchDataWithTypeResult<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = createUrlRequest(url: url) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print(error?._code ?? "0")
                completion(.failure(NetworkError.requestFailed))
                return
            }
            
            do {
                let decodedResponse  = try JSONDecoder().decode(decodable.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }
        .resume()
    }
    
    // !!!!!!!!!!!!!!!!!!!!!!!! GENERIC VERSION !!!!!!!!!!!!!!!!!!!!!
    
//    static func fetchData<T: Codable>(url: String, decodable: T.Type, completion: @escaping (T?, Error?)->Void) {
//        guard let urlRequest = createUrlRequest(url: url) else {
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
