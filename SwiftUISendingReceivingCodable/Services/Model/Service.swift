//
//  Service.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 19/11/2020.
//

import Foundation

protocol Service {
    typealias serviceResult<T> = Result<T, NetworkError>
    typealias velibResult = Result<VelibResponse, NetworkError>
    typealias trotinetteResult = Result<TrotinetteResponse, NetworkError>
    typealias SanisetteResult = Result<SanisetteResponse, NetworkError>
    typealias fontaineResult = Result<FontaineResponse, NetworkError>
    typealias triMobileResult = Result<TriMobileResponse, NetworkError>
    
    var id: String? { get set }
    var typeService: ServicesEnum { get set }
    func fetchDetail(of service: ServicesEnum,
                     urlString: String,
                     completionHandler: @escaping (Service?, Bool, NetworkError?) -> Void)
    func createService<T>(data: T) -> Service?
}
