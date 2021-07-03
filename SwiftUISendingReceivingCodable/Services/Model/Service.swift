//
//  Service.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/11/2020.
//

import Foundation

protocol Service {
    typealias ServiceResult<T> = Result<T, NetworkErrorEnum>
    typealias VelibResult = Result<VelibResponse, NetworkErrorEnum>
    typealias TrotinetteResult = Result<TrotinetteResponse, NetworkErrorEnum>
    typealias SanisetteResult = Result<SanisetteResponse, NetworkErrorEnum>
    typealias fontaineResult = Result<FontaineResponse, NetworkErrorEnum>
    typealias TriMobileResult = Result<TriMobileResponse, NetworkErrorEnum>
    typealias ArbreRemarquableResult = Result<ArbreRemarquableResponse, NetworkErrorEnum>
    typealias ColonneVerreResult = Result<ColonneVerreResponse, NetworkErrorEnum>
    typealias WifiHotSportResult = Result<WifiHotspotResponse, NetworkErrorEnum>
    
    var id: String? { get }
    var typeService: ServicesEnum { get }
    func fetchDetail<T: Codable>(of service: ServicesEnum,
                                  urlString: String,
                                  type: T.Type,
                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void)
}

extension Service {
    func fetchDetail<T: Codable>(of service: ServicesEnum,
                                  urlString: String,
                                  type: T.Type,
                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
        RepositoryNetworking.shared.fetchDetail(of: service,
                                                urlString: urlString) { (result: Result<T, NetworkErrorEnum>) in
            
            switch result{
            case .success(let data):
                let responseData = data as! Response
                if let service = responseData.records?.first {
                    completionHandler(service, false, nil)
                } else {
                    completionHandler(nil, true, NetworkErrorEnum.dataNotFound)
                }
            case .failure(let error):
                completionHandler(nil, true, error)
            }
        }
    }
}
