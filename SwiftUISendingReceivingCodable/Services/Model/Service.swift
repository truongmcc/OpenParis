//
//  Service.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/11/2020.
//

import Foundation

protocol Service {
    typealias serviceResult<T> = Result<T, NetworkErrorEnum>
    typealias velibResult = Result<VelibResponse, NetworkErrorEnum>
    typealias trotinetteResult = Result<TrotinetteResponse, NetworkErrorEnum>
    typealias SanisetteResult = Result<SanisetteResponse, NetworkErrorEnum>
    typealias fontaineResult = Result<FontaineResponse, NetworkErrorEnum>
    typealias triMobileResult = Result<TriMobileResponse, NetworkErrorEnum>
    typealias arbreRemarquableResult = Result<ArbreRemarquableResponse, NetworkErrorEnum>
    typealias colonneVerreResult = Result<ColonneVerreResponse, NetworkErrorEnum>
    
    var id: String? { get set }
    var typeService: ServicesEnum { get set }
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkErrorEnum?) -> Void)
    func createService<T>(data: T) -> Service?
}
