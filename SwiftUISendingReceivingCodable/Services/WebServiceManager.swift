//
//  WebServiceManager.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import Foundation

enum NetworkError: Error {
    
    case badURL, requestFailed, decodingFailed, unknown, noInternet, serverNotAccessible
    
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
    
    static func createUrlRequest(url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        return URLRequest(url: url)
    }
    
    // !!!!!!!!!!!!!!!!!!!!!!!! GENERIC VERSION !!!!!!!!!!!!!!!!!!!!!
    static func getContent<T: Codable>(url: String, decodable: T.Type, completion: @escaping (T?, Error?)->Void) {
        guard let urlRequest = createUrlRequest(url: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print(error?._code ?? "0")
                completion(nil, error)
                return // Handling errors in an enum
            }
            
            do {
                let decodedResponse  = try JSONDecoder().decode(decodable.self, from: data)
                completion(decodedResponse, nil)
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    static func getContentWithTypeResult<T: Codable>(url: String, decodable: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
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
    
    
    
}
