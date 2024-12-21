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
    typealias SanisetteResult = Result<SanisetteResponse, NetworkErrorEnum>
    typealias fontaineResult = Result<FontaineResponse, NetworkErrorEnum>
    typealias TriMobileResult = Result<TriMobileResponse, NetworkErrorEnum>
    typealias ArbreRemarquableResult = Result<ArbreRemarquableResponse, NetworkErrorEnum>
    typealias ColonneVerreResult = Result<ColonneVerreResponse, NetworkErrorEnum>
    typealias WifiHotSportResult = Result<WifiHotspotResponse, NetworkErrorEnum>
    //associatedtype typeResponse
    //var type: typeResponse { get set }
    //typealias typeResponse = VelibResponse
    
    var id: String? { get }
    var typeService: ServicesEnum { get }
    func fetchDetail(of service: ServicesEnum,
                                  urlString: String,
                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void)
}

extension Service {
//    func fetchDetail(of service: ServicesEnum,
//                                  urlString: String,
//                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void) {
//        RepositoryNetworking.shared.fetchDetail(of: service,
//                                                urlString: urlString) { (result: Result<typeResponse, NetworkErrorEnum>) in
//            
//            switch result{
//            case .success(let data):
//                if let service = data.records?.first {
//                    completionHandler(service, false, nil)
//                } else {
//                    completionHandler(nil, true, NetworkErrorEnum.dataNotFound)
//                }
//            case .failure(let error):
//                completionHandler(nil, true, error)
//            }
//        }
//    }
}
