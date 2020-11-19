//
//  ServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 06/11/2020.
//

import SwiftUI

protocol Service {
    
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
}

protocol serviceResponseAliasProtocol {

}

class ServiceViewModel:serviceResponseAliasProtocol, ObservableObject {
    @Published var service: Service?
    @Published var typeServiceSelected = ServicesEnum.velib
 
    func fetchAnnotationDetail(recordId: String,
                                finished: @escaping (Bool, NetworkError?) -> Void) {

        let url = typeServiceSelected.annotationUrl() + recordId
        
        service = typeServiceSelected.create()
        service?.fetchDetail(of: typeServiceSelected, urlString: url) { service, showError, networkError in
            DispatchQueue.main.async {
                self.service = service
                finished(showError, networkError)
            }
        }
    }
}
