//
//  Decoding.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/06/2021.
//

import Foundation

class Decoding {
    let data: Data?
    init(data: Data?) {
        self.data = data
    }
    func decode<T: Codable>(data: Data?, decodable: T.Type) -> T? {
        guard let encodedData = data else {
            return nil
        }
        do {
            let decodedData = try JSONDecoder().decode(decodable.self, from: encodedData)
            return decodedData 
        } catch {
            print(error)
        }
        return nil
        
    }
}
