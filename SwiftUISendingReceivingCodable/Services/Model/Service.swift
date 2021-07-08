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
    func fetchDetail(of service: ServicesEnum,
                                  urlString: String,
                                  completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void)
}
