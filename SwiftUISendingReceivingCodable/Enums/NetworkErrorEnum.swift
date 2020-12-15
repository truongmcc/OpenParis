//
//  NetworkErrorEnum.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 15/12/2020.
//

enum NetworkErrorEnum: Error {
    
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
