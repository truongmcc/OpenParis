//
//  ServicesWebServices.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

class ServicesWebServices {
    
    static let shared = ServicesWebServices()
    private init() { }
    
    func fetchAllAnnotations(of userSettings: UserSettings, centerCoordinate: (Double, Double), completion: @escaping (Result<ResponseAnnotationDatas, NetworkErrorEnum>) -> Void) {
        let url = CreateUrl(userSettings: userSettings, centerCoordinate: centerCoordinate)
        NetworkManager.shared.fetchDataWithTypeResult(url: url, decodable: ResponseAnnotationDatas.self) { result in
            completion(result)
        }
    }
    
    func CreateUrl(userSettings: UserSettings, centerCoordinate: (x: Double, y: Double)) -> String {
        let endPoint = userSettings.typeService.allAnnotationsEndpoint()
        var param = ""
        if userSettings.rayOfDistance <= 700 {
            param = "&geofilter.distance=\(centerCoordinate.x)%2C\(centerCoordinate.y)%2C\(String(userSettings.rayOfDistance))"
        }
        return endPoint + param
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

