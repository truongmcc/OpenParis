//
//  DataFetcher.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/06/2021.
//

import Foundation

class DataFetcher {
    let urlRequest: URLRequest
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
    
    func fetchData(urlRequest: URLRequest, completion: @escaping (Data?, NetworkErrorEnum?) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil, NetworkErrorEnum.requestFailed)
                return
            }
            print(data)
            completion(data, nil)
        }
        .resume()
    }
}
